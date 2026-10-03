# DBACOCKPIT – HTTP 500 en SAP BAS (Sybase ASE) – Diagnóstico y solución

Registro de la sesión del 03.10.2026. Sirve como paso a paso para volver a dejar DBACOCKPIT funcionando si se reinstala el sistema.

## Entorno

| Dato | Valor |
|---|---|
| Sistema | BAS, instancia `DVEBMGS00`, host `sapzrv` (192.168.1.12) |
| Mandantes | 000 y 001 (sistema único, con transporte entre mandantes) |
| SAP_BASIS | 731 (ECC6 EHP6), kernel 722 |
| Base de datos | Sybase ASE 15.7.0.132 |
| SO | Windows Server |
| SAP GUI | 770 |

## Síntoma

Al ejecutar `DBACOCKPIT`, el área web de la transacción muestra **"HTTP 500 – Internal Server Error"**. En otros intentos, la transacción cae en dumps del modo SAP GUI clásico.

## Resumen de causas

Las causas se fueron destapando en cascada: al resolver una, aparecía la siguiente.

| # | Causa | Dónde se vio | Solución |
|---|---|---|---|
| 1 | La URL salía sin dominio (`sapzrv`); Web Dynpro exige nombre completo (FQDN) | ST22: `UNCAUGHT_EXCEPTION` / `CX_FQDN`; ST11: `dev_icf*` | `icm/host_name_full` y archivo hosts |
| 2 | Servicios SICF de íconos inactivos | ST11 `dev_icf*`: "ICF service node /sap/public/bc/icons is not active" | Activar 4 nodos en SICF |
| 3 | Servicios SICF de Web Dynpro inactivos | ST11 `dev_icf*`: "…/webdynpro/adobeChallenge/ is not active" | Activar 5 subnodos en SICF |
| 4 | Código estándar `CL_DB6_SYS→SYNCHRONIZE_SYSTEM_DATA` (SAP, 08.09.2011) no contempla `SYB` y lanza "Database of selected system is not supported" | ST22: `SYSTEM_CLASSCONSTRUCTOR_FAILED`, `OBJECTS_OBJREF_NOT_ASSIGNED` en `CX_DBA_ROOT`; debugger | Mejora implícita `ZE_DB6_SYS_SYB` |

Cosas que **no** eran el problema y conviene no volver a perseguir:

- **Base de datos:** Sybase responde bien y DBCON tiene `+++SYBADM` correcto.
- **ICM:** está corriendo, con HTTP 8000 y HTTPS 44300 activos y SSL OK.
- **Work processes:** sin errores.
- **Notas que no aplican:** 2695241 es para USMM/SLAW y sólo coincide en los nodos SICF; 1170197 (TDMS) y 2731610 (Digital Access) no tienen relación.
- **Abrir la aplicación desde Chrome, Edge o Edge en modo IE no sirve:** Web Dynpro 7.31 rechaza esos navegadores ("This browser is not supported"). La prueba válida es desde SAP GUI.

---

## Paso a paso de la solución

### Paso 1 – Nombre completo del host (FQDN)

**1a. Archivo hosts** (en el servidor y en cada PC con SAP GUI), como administrador:

`C:\Windows\System32\drivers\etc\hosts`

```
192.168.1.12    sapzrv.lab.local    sapzrv
```

En esta sesión también se borró una línea vieja que no se usaba: `127.0.0.1 sapzrv.local`.

Verificar con `ping sapzrv.lab.local`: tiene que responder 192.168.1.12.

**1b. Parámetro de perfil**, en RZ10:

1. Perfil `BAS_DVEBMGS00_SAPZRV` → Extended maintenance → Change.
2. Crear el parámetro `icm/host_name_full` con el valor `sapzrv.lab.local`.
3. Copy → Back → Save → **Activate: Yes**.

**1c. Reiniciar la instancia completa** (SAP MMC: Restart).

> Reiniciar sólo el ICM desde SMICM **no** alcanza: el ICM lee los parámetros de la memoria compartida que se carga al arrancar la instancia, y `icm/host_name_full` no se puede cambiar en caliente.

**Verificar:** SMICM → Goto → Parameters → Display → `icm/host_name_full = sapzrv.lab.local`.

### Paso 2 – Servicios SICF (los 9 nodos)

En SICF, filtrar por la ruta `/sap/public`, expandir `bc` y, en cada nodo, clic derecho → **Activate Service → Yes**:

```
/sap/public/bc/icons
/sap/public/bc/icons_rtl
/sap/public/bc/pictograms
/sap/public/bc/webicons
/sap/public/bc/webdynpro/adobeChallenge
/sap/public/bc/webdynpro/mimes
/sap/public/bc/webdynpro/Polling
/sap/public/bc/webdynpro/ssr
/sap/public/bc/webdynpro/ViewDesigner
```

Estos ya estaban activos y hay que confirmar que sigan así: `/sap/bc/webdynpro/sap/dba_cockpit`, `/sap/public/bc/webdynpro`, `/sap/public/bc/ur` y `/sap/public/myssocntl`.

> Si un nodo padre ya está activo, sus subnodos inactivos no se activan en cascada: hay que activarlos uno por uno.

### Paso 3 – Mejora implícita `ZE_DB6_SYS_SYB`

**Qué corrige:** en `CL_DB6_SYS→SYNCHRONIZE_SYSTEM_DATA`, el `CASE me->sys_data-dbsys` no tiene rama para `'SYB'`. Sybase cae en `when others` y se ejecuta `raise exception type cx_db6_sys ... rc = cl_db6_rc=>x_wrong_database`. El código no fue modificado: en SE95 no hay modificaciones y su única versión es la de SAP de 2011.

**Cómo crearla:**

1. SE24 → `CL_DB6_SYS` → Display → menú **Class → Enhance**.
2. Enhancement Implementation: `ZE_DB6_SYS_SYB`, texto breve "Soporte SYB DBACOCKPIT" → OK → **Local Object** ($TMP).
3. En la pestaña Methods, seleccionar `SYNCHRONIZE_SYSTEM_DATA` → **Edit → Enhancement Operations → Insert Overwrite-Method**.
4. A la pregunta de acceso a los componentes privados y protegidos, responder **Yes**.
5. Hacer clic en el ícono de la columna Overwrite-Exit y guardar cuando lo pida.
6. En **otra sesión**, abrir el método original (SE24 → `CL_DB6_SYS` → doble clic en `SYNCHRONIZE_SYSTEM_DATA`), **Ctrl+A** y **Ctrl+C**.
7. En el editor de la mejora, poner el cursor en la línea vacía entre el bloque de comentarios y `ENDMETHOD.` y hacer **Ctrl+V**.
8. Comentar con `*` las líneas pegadas `method synchronize_system_data .` y `endmethod.`, porque el método de la mejora ya tiene las suyas.
9. **El cambio funcional:**

   ```diff
   -    when 'ORA'.
   +    when 'ORA' or 'SYB'.
        when others.
          raise exception type cx_db6_sys ...
   ```

10. **Ajustes para que compile.** Usar Ctrl+H con **Match Case** activado, para no tocar el `ME->CORE_OBJECT` del constructor, que va en mayúsculas.

    | Buscar | Reemplazar | Cant. |
    |---|---|---|
    | `me->` | `core_object->` | 102 |
    | ` contype_` | ` cl_db6_sys=>contype_` | 14 |
    | ` get_connection_type(` | ` core_object->get_connection_type(` | 6 |
    | ` is_supported_` | ` core_object->is_supported_` | 4 |
    | ` sysentry_` | ` cl_db6_sys=>sysentry_` | 1 |
    | ` systype_` | ` cl_db6_sys=>systype_` | 3 |
    | `= me )` | `= core_object )` | 2 |
    | `modify table systems` | `modify table cl_db6_sys=>systems` | 1 (a mano) |

    Las cantidades corresponden a SAP_BASIS 731 con este nivel de SP. Con otro nivel pueden cambiar: hay que seguir corrigiendo hasta que la verificación de sintaxis (Ctrl+F2) quede limpia.

11. **Ctrl+F2** debe dar "syntactically correct" → **Ctrl+S** → **Ctrl+F3**.
12. En la lista de objetos inactivos, **marcar sólo `ZE_DB6_SYS_SYB`** y confirmar. Tiene que aparecer "Object(s) activated" y el estado **Active**.

> Ninguno de los cambios de esta guía depende del mandante: la mejora, el perfil, el archivo hosts y SICF aplican a 000 y a 001 por igual, así que no hace falta transportarlos ni copiarlos entre mandantes (SCC1). La mejora se creó como objeto local ($TMP) porque es un sistema único; si se quiere registrarla en una orden de transporte, se puede reasignar después con Goto → Object Directory Entry.

### Paso 4 – Verificación final

1. `/nDBACOCKPIT` desde SAP GUI: se carga la aplicación web sin pedir login.
2. **System Configuration:** BAS / Sybase ASE / 731 / `+++SYBADM`, estado en verde, con el mensaje *"Database connection +++SYBADM established successfully"*.
3. **Database BAS → Performance → Processes:** muestra datos reales (uptime, procesos).
4. ST22: sin dumps nuevos de `CX_DBA_ROOT`, `CL_DB6_SYS` ni `CX_FQDN`.

---

## Herramientas de diagnóstico usadas

| Transacción | Para qué |
|---|---|
| SM51 / SM50 | Estado de la instancia y de los work processes |
| SMICM | Estado del ICM, servicios (puertos), trace `dev_icm`, parámetros activos |
| SICF | Estado de los servicios ICF |
| ST22 | Dumps (`CX_FQDN`, `SYSTEM_CLASSCONSTRUCTOR_FAILED`, `OBJECTS_OBJREF_NOT_ASSIGNED`) |
| **ST11 → `dev_icf*`** | **Clave**: registra el motivo real de cada HTTP 500 de ICF/Web Dynpro, con URL y pila de llamadas |
| SM21 | Log del sistema (aviso de DNS al arrancar) |
| RZ11 / RZ10 | Parámetros (`icm/host_name_full`, `SAPLOCALHOSTFULL`) y perfil |
| SE16 | `DBCON`, `DB6NAVSYST`, `HTTPURLLOC`, `SPERS_OBJ`, `USR05` |
| SE24 / SE38 / SE93 | Lectura de código (`CL_DB6_SYS`, `CL_DB6_TREE_NAVIGATOR`, `CX_DBA_ROOT`) |
| Debugger + punto de parada externo | Confirmar el `raise` de la línea 306 y probar el fix antes de implementarlo |
| SE95 / gestión de versiones | Confirmar que el código estándar no estaba modificado |

### Truco útil: probar el fix sin tocar código

1. En SE24, abrir `CL_DB6_SYS→SYNCHRONIZE_SYSTEM_DATA`, poner el cursor en el `raise exception` de `when others` y hacer **Ctrl+Shift+F9** (punto de parada externo, vale para los pedidos HTTP).
2. Ejecutar DBACOCKPIT. En cada parada, poner el cursor en la línea `me->migrate_old_entries( ).` y usar **Debugger → Goto statement** (Shift+F12), y después F8.
3. Si el cockpit carga, el fix sirve. Al terminar, borrar el punto de parada: Utilities → External Breakpoints → Delete.

## Cómo deshacer la mejora

SE24 → `CL_DB6_SYS` → Class → Enhance → borrar o desactivar la implementación `ZE_DB6_SYS_SYB`.

Si se sube el support package de SAP_BASIS, revisar en **SPAU_ENH** si hace falta ajustarla, o desactivarla si SAP ya incluye el soporte para `SYB`.

## Pendientes / notas

- **Certificado HTTPS:** está emitido para `sapzrv`, así que el navegador embebido muestra una advertencia de nombre. Opcional: regenerar SAPSSLS en STRUST para `sapzrv.lab.local`.
