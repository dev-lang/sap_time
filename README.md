# sap_time
Scripts varios para preparar un sistema SAP

Acerca de byebyetimer: es un script para evitar que la VM de SAP sincronice la hora con el host
en aquellos sistemas con licencia vencida, puede servir para continuar utilizando sap.

### LEER READMES INCLUIDOS EN CASO DE PRESENTAR PROBLEMAS CON VBS
scripts probados en SAP GUI, en caso de presentar fallas instalar gui750_11-80001468.exe

**ADVERTENCIA: Las operaciones que se realicen, deben hacerse en la medida de lo posible en un cliente diferente a 000 y 001<br>
Se puede crear un cliente más en la transacción SCC4
Usar las instrucciones solamente como referencia en pruebas iniciales pero crear un mandante independiente**

# Índice

- [Notas de instalación](#notas-de-instalación)
- [Recomendación de configuración](#recomendacion-de-configuración)
- [VMC container is not active on this application server](#vmc-container-is-not-active-on-this-application-server)
- [Configuraciones exitosas de VM](#configuraciones-exitosas-de-vm)
- [Files](#files)
- [Linux SAP Ubuntu 18.10](#linux-sap-ubuntu-1810)
- [Windows Server 2008 R2 - KB3004394 Obligatoria](#windows-server-2008-r2---kb3004394-obligatoria)
- [Crítico: Instance xxxd00 reached state shutdown after having state starting giving up](#critico-instance-xxxd00-reached-state-shutdown-after-having-state-starting-giving-up)
- [UAC](#uac)
- [Log off](#log-off)
- [Password](#password)
- [Unable to find a database software package at xxsap-ase-db](#unable-to-find-a-database-software-package-at-xxsap-ase-db)
- [Selección de exports](#selección-de-exports)
- [Selección de exports automática](#selección-de-exports-automática)
- [Microsoft C Runtimes 2012 Update 4](#microsoft-c-runtimes-2012-update-4)
- [Port Forwarding Solo NAT](#port-forwarding-solo-nat)
- [Instalación completa](#instalación-completa)
- [Product Catalog](#product-catalog)
- [No connect to database session terminated](#no-connect-to-database-session-terminated)
- [DBA Cockpit - Objects Objref Not Assigned Dump](#dbacockpit---objects_objref_not_assigned-dump-notas-17-03-2025)
- [Configurar ST03N](#configurar-st03n)
- [Error 403 Web Dynpros](#error-403-web-dynpros)
- [Crear un certificado SSL](#crear-un-certificado-ssl)
- [SWNC Tcoll Starter - No Authorization for Transaction ST07](#swnc_tcoll_starter---no-authorization-for-transaction-st07)
- [IPv4](#ipv4)
- [Resource Temporarily Unavailable - Partner X3200 Not Reached](#resource-temporarily-unavailable-partner-x3200-not-reached)
- [CPU Timers Not Synchronized - Check Note 1036194](#cpu-timers-not-synchronized-check-note-1036194)
- [A raise statement in program cl_gui_html_viewercp has raised exception condition](#a-raise-statement-in-program-cl_gui_html_viewercp-has-raised-exception-condition-cntl_error)
- [Crear nuevo cliente](#crear-nuevo-cliente)
- [Reiniciar instancia sin usar SAPMMC](#reiniciar-instancia-sin-usar-sapmmc)
- [Fix No Default CO Address Has Been Maintained in the System](#fix-no-default-co-address-has-been-maint-in-the-system-create-an-address)
- [Fix Address Doesn't Exist 22787 - SAP Note 1420281](#fix-address-doesnt-exist-22787--sap-note-1420281)
- [STMS Configurar Ruta de Transporte Local entre Clientes 000 y 001](#stms-configurar-ruta-de-transporte-local-entre-clientes-000-y-001)
- [Salir de Transacción Si No Funciona la Opción de Detener Transacción](#salir-de-transacción-si-no-funciona-la-opción-de-detener-transacción)
- [Table Class Is C - Entries Are Only Imported to Client 000](#table-class-is-c-entries-are-only-imported-to-client-000)
- [Client 000 Has Status Not Modifiable](#client-000-has-status-not-modifiable)
- [The Data is Locked by User - And Can Be Displayed Only](#the-data-is-locked-by-user--and-can-be-displayed-only)
- [Transporte de OTs entre Clientes](#transporte-de-ots-entre-clientes)
- [System Unknown in Transport Management System](#system-unknown-in-transport-management-system)
- [SU25 - PFCG Autorizaciones](#su25---pfcg-autorizaciones)
- [Tracear Autorizaciones Pendientes Sin SU53](#tracear-autorizaciones-pendientes-sin-su53)
- [FIX Autorizaciones BATCH - SM36 user is no authorized to schedule program](#sm36-user--is-not-authorized-to-schedule-program--as-a-background-job)
- [Renovar Licencia - Habilitar Developer Key](#renovar-licencia--habilitar-developer-key)
- [Activar SAP Scripting](#activar-sap-scripting)
- [Actualizar Kernel Notas](#actualizar-kernel-notas)
- [Referencias](#referencias)


# NOTAS DE INSTALACIÓN:

1. Se debe instalar el OS elegido (se ha probado Win2016 para ECC6 EHP6 y Win2012 R2 para ECC EHP8)
2. Ejecutar el preset correspondiente
3. Verificar que se hayan instalado los pre-requisitos necesarios (puede requerirse un seteo de PATH en caso de instalar Java)
4. Copiar los archivos de instalación en un disco aparte
5. Copiar el archivo .bat correspondiente<br>
   (por ejemplo, para SAP ECC6 EHP8 bajo Win2012R2 se requiere una estructura así:<br>
   <img width="469" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/8a75964a-8010-4a8b-88b7-39a4b145877a"><br>
   para la ECC6 debe tener una estructura similar a la siguiente:<br>
   ![image](https://github.com/dev-lang/sap_time/assets/56205122/76b6d92b-82c9-430f-864b-7efce40caa83)<br>
   y el ejemplo del .bat funcionando:<br>
   ![image](https://github.com/dev-lang/sap_time/assets/56205122/ca7e12ec-840f-439d-a92a-acb412eb2ec1)<br>
   Para la ECC7 debe quedar de esta forma:<br>
   ![image](https://github.com/user-attachments/assets/5c6b2c6b-6427-44e6-b829-25717be9fdc8)<br>

En el siguiente enlace se dejaron los archivos exe para descomprimir en cualquiera de los casos (ECC7, ECC6 o ECC8):<br>
https://archive.org/details/sapinst-tools

7. Ejecutar .BAT y seguir las instrucciones y notas de este README

# Recomendacion de configuración

## Recomendacion de seteo ECC6 EHP6:
```
1- Configurar usuarios de contingencia con permisos SUPER/SAP_ALL
2- Setear horario de servidor y AS en misma zona horaria
3- Configurar roles y job para SAP_COLLECTOR_FOR_PERFMONITOR
4- En RZ10 importar perfiles (Utilities > Import Profiles > of Active Servers)
5- En caso de no funcionar DBACOCKPIT revisar paso 2 y configurar según notas de SM30 y ST03N
	a - setear job sap_collector_for_perfmonitor
	b - configurar parámetros en rz10, perfil de INSTANCIA 
      nota: para ver los parámetros actuales, usar la transacción RSPFPAR o RZ10
	c - no olvidar que se debe reiniciar AS y servicio de instancia (em services.msc)
6- Revisar Servicios requeridos en SICF
7- Configurar SUCOMP en 000, establecer Standard Address y configurar STMS 
	(Si pide clave usar la misma que definimos al instalar)

NOTA: el usuario sapsa debe tener por defecto la clave master que definimos al instalar la instancia.
```

## Java is NOT ACTIVE (VM Container)

Esta advertencia que podemos llegar a ver dentro del sapmmc.mmc es debido a que no se encuentra instalada
Java en el sistema. Para ello deberemos instalar Java en el sistema. 

En caso de requerir descargar el instalador de Java 2, usar el siguiente enlace (testeado con ECC6 EHP6): <br>
https://archive.org/download/j2sdkfb-1_4_2_29-windows-amd64/j2sdkfb-1_4_2_29-windows-amd64.exe<br>
Puede dar un error en la primera ejecución pero después funciona correctamente.<br>
<img width="202" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/1300fb19-a781-423e-bb69-b6c77d93addc">

Después se requiere configurar los PATH del sistema (se agregará un script .ps1)<br>

Nota 19-03-2025: Ver solución de VMC Container

## VMC Container is not active on this application server

Agregar el siguiente parámetro al perfil de instancia:
```
vmcj/enable	on
```

Esto soluciona tambien el "Java is not active"

# CONFIGURACIONES EXITOSAS (DE VM):

Nota: tener en cuenta que la configuración de disco puede cambiar a nivel OS si se hacen discos dinámicos.
Los datos son de referencia y puede ser que haya mejoras en una reconfiguración previa o posterior.

## SAP ECC6 EHP6:

| Configuración         | Detalles                       |
|-----------------------|--------------------------------|
| Sistema Operativo     | Windows Server 2016            |
| RAM                   | 8192MB                         |
| CPU                   | 2 Núcleos                      |
| Tarjeta de Video      | VBoxSVGA (Sin 3D)               |
| Memoria de Video      | 128MB                          |
| Disco Principal       | 100GB VHD                      |
| Disco Secundario      | 100GB VHD                      |
| Disco Terciario       | 180GB VHD                      |
| Configuración de Red  | NAT / Puente                   |

## SAP ECC6 EHP8:

| Configuración         | Detalles                       |
|-----------------------|--------------------------------|
| Sistema Operativo     | Windows Server 2012 R2         |
| RAM                   | 10127MB                        |
| CPU                   | 2 Núcleos                      |
| Tarjeta de Video      | VBoxSVGA (3D)                   |
| Memoria de Video      | 256MB                          |
| Disco Principal       | 100GB VHD                      |
| Disco Secundario      | 250GB VHD                      |
| Disco Terciario       | 64GB VHD                       |
| Configuración de Red  | NAT / Puente                   |



# FILES:

Descripción rápida de uso de cada archivo (no necesariamente se requiere el uso de todos por eso ver la tabla).

| Nombre del Archivo               | Descripción                                                        |
|---------------------------------|--------------------------------------------------------------------|
| preset_machine.ps1               | Preconfigura la máquina con el nombre "sapsrv" y establece PageFile en 20500MB |
| win2008_preset_machine.ps1        | [WIN2008] Preconfigura la máquina con nombre, muestra extensiones de archivos, establece PageFile y deshabilita UAC |
| preset_all.ps1                   | Preconfigura el nombre del host, PageFile, muestra extensiones de archivos, abre el puerto TCP 3200 y deshabilita UAC |
| ws2016_fw_rules.ps1              | Abre los puertos TCP 3200 entrantes y salientes en el cortafuegos      |
| 2016_DISABLE_UAC_EHP6.ps1        | Deshabilita UAC en Windows Server 2016                                 |
| SAP_ECC6_EHP6_Source.bat         | [WIN2016] Prepara la instalación para ECC6 EHP6                          |
| ECC6_EHP8_ws2012.bat             | [WIN2012] Prepara la instalación de ECC6 EHP8 en Windows 2012           |
| ECC6_EHP7.bat			   | [WIN] Prepara la instalación de ECC6 EHP7 (probado en WS2016)		|
| ECC6_EHP8.bat                    | Prepara la instalación de ECC6 EHP8                                      |
| comp-readme.txt                  | Notas sobre el Código de la Compañía y PFCG                               |
| byebyetimer.bat                  | Desactiva la configuración de hora y realiza varias configuraciones para SAP Netweaver en Windows Server 2003 |
| Linux_Ubuntu-1810.sh             | Prepara sistema Linux para SAP (Script parcial) |
| enable_rds.ps1                   | Habilita el uso de RDS para conexión remota al equipo |
| disable_ipv6-loopback.ps1        | Desactivar IPV6 (WinServer 2012) |

## Linux SAP (Ubuntu 18.10):

Seguir instrucciones de guía:
https://blogs.sap.com/2022/11/14/sap-netweaver-as-abap-developer-edition-installation-pitfalls/<BR>
Archive: https://web.archive.org/web/20240115104202/https://blogs.sap.com/2022/11/14/sap-netweaver-as-abap-developer-edition-installation-pitfalls/<BR>

Algunos pasos se encuentran parcialmente cubiertos en script Linux_Ubuntu-1810.sh (paso 5 a 8 incluyendo hostname)<br>

Ejecutar realizando:
```
chmod +x Linux_Ubuntu-1810.sh
./Linux_Ubuntu-1810.sh
```


## Windows Server 2008 R2 - KB3004394 Obligatoria

Es requerida la actualización KB3004394 (https://support.microsoft.com/en-us/topic/support-for-urgent-trusted-root-updates-for-windows-root-certificate-program-in-windows-a4ac4d6c-7c62-3b6e-dfd2-377982bf3ea5)
para poder instalar los NTPATCH que se requieren en el proceso de instalación.


![image](https://github.com/dev-lang/sap_time/assets/56205122/46fb792a-0263-4c98-9086-3c9325971361)

podemos comprobar esto al intentar instalar manualmente tanto el vcredist como alguna update de windows y nos salga el siguiente mensaje:<br>
![image](https://github.com/dev-lang/sap_time/assets/56205122/51c1013c-539b-4e84-864c-e5b4372a60d5)<br>

Una vez instalada la update, reiniciar el sistema y continuar el proceso.

## [CRITICO] Instance XXX/D00 reached state SHUTDOWN after having state STARTING. Giving Up

Durante el proceso de instalación, en la etapa de start instance, nos puede salir un error que figura que no ha podido iniciarse
la instancia de sap requerida

![image](https://github.com/dev-lang/sap_time/assets/56205122/91f06e78-6663-4e8a-92f5-959fba630ac6)

Si ingresamos al "SAP Management Console" podremos ver el status de las process list de cada instancia. 
En caso de que se encuentren en "STARTING" podremos hacer click en "Retry" para que el proceso de instalación continúe.

Este problema puede deberse a una falta de memoria por lo que aumentar la RAM asignada a la VM parece solucionar el problema
Recomendado: asignar por lo menos 10127MB de memoria.

## UAC

Es requerida la desactivación para la instalación de ECC6 EHP6 bajo Windows 2016<br>
Se ha incluido el script 2016_DISABLE-UAC_EHP6.ps1 para tal tarea<br>
La alternativa es el siguiente código pero requiere reinicio manual:<br>

```Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 0```


## log-off

En el primer paso de instalación, se solicitará al usuario que cierre su sesión.
En caso de fallar se requiere que se cambien las siguientes configuraciones (secpol.msc):

**Act as part of the operating system, Increase quotas and Replace a process level token.**

En primera instancia, con que el usuario que usamos para instalar se encuentre en esas configuraciones,
es suficiente para permitir la instalación.
Puede ser que "Increase quotas" no se encuentre en windows server 2019


## password

Es importante generar una clave segura tanto para mantener el sistema seguro como para que la instalación sea correcta en todo el proceso.
En cuanto el instalador requiera establecer una contraseña a los usuarios que se crean y se encuentre con la limitación de haber elegido
una clave que no cumple con los requisitos, puede encontrarse con un error que impida continuar.

ESET Password Generator: https://www.eset.com/int/password-generator/<br>
Secure Password Generator: https://passwordsgenerator.net/old.php

**RECORDAR LA CLAVE YA QUE SERÁ REQUERIDA PARA LA ADMINISTRACIÓN DEL SISTEMA SAP**

## Unable to find a database software package at x:\x\SAP ASE DB.

Se requiere utilizar el archivo ASEBS16003P_14-10013281.SAR para el paso. 
Antes debe ser descomprimido utilizando la herramienta sapcar.exe
el paso ha sido incluido a partir del commit 10ce30f en el script ECC6_EHP8.bat

Debería quedar de esta forma:<br>
<img width="312" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/671f288a-d986-46c1-a5da-49cefe49a5b0"><br>
Nota: el script run.bat fue un script realizado con el siguiente comando (mismo comando incluido en script ECC6_EHP8.bat):<br>

```sapcar.exe -xvf *.SAR```

## Selección de exports

Debido a un bug visual del instalador, es posible que los números de exports solicitados no sean iguales a los requeridos.
En el mismo error que figura en pantalla puede verse un número de este estilo:

```SAP:ECC:618:EXPORT(1/11):ERP 6.0 EhP8 Installation Export CD 1/11:CDxxxxxxxx_1```

donde el x/xx indica el número que debe ser idéntico al solicitado. En los primeros dos pasos pide el export 1 y 11 en lugar del export 2
en el tercer paso requiere (en la prueba realizada) que se pongan en el siguiente orden:

![image](https://github.com/dev-lang/sap_time/assets/56205122/01c118cd-90a6-46ea-a832-54909d07d308)

nota: el ejemplo de arriba obvia el export 2 debido a que fue cargado anteriormente
si respetamos la solicitud cargando 1 y 11 debería ser así:
![image](https://github.com/dev-lang/sap_time/assets/56205122/67851d85-781d-4609-9970-b869210b5e08)

Una vez iniciado el proceso, el SPM comenzará a verificar todos los archivos

## Selección de exports (automática)

En lugar de establecer la ruta de cada carpeta, podremos en el paso 1 o 2, decirle que los busque en la carpeta 51050708

por ejemplo:
```E:\ECC6 EHP8\ECC6 EHP8 Exports\51050708\```

**El SPM se encargará de buscarlos dentro de la carpeta DATA_UNITS**

<img width="1192" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/b288ec1e-e206-47b6-b277-727efbf41b1e">


## Microsoft C++ Runtimes 2012 Update 4

Durante el proceso de instalación puede ocurrir el siguiente error, que indica que nos faltan instalar unas runtimes en el sistema para poder continuar.
Podemos bajarlo desde: https://archive.org/download/visual-c-redistributable-for-visual-studio-2012-update-4/Visual%20C%2B%2B%20Redistributable%20for%20Visual%20Studio%202012%20Update%204.zip/vcredist_x64.exe para instalarlo y continuar con el proceso.

![image](https://github.com/dev-lang/sap_time/assets/56205122/b9d60505-6f76-4366-9a42-498830192214)


## PORT FORWARDING (solo NAT)

En caso de realizar NAT, es requerido un port forwarding para poder comunicar 
el cliente local con el servidor de la vm<br>
<img width="614" alt="NAT PF" src="https://github.com/dev-lang/sap_time/assets/56205122/cbe364b3-c364-4927-a936-6eb7d78db660"><br>

Para el resto de los servicios se deberá hacer lo mismo

NOTA: Es recomendable usar un puente en lugar de NAT, si se utiliza una máquina host diferente al cliente 
o si se desea permitir varios clientes o que la vm tome el dominio (p.e: sapprd.dominio.com.ar)

## Instalación completa

Una vez finalizada la instalación, aparecerá el siguiente mensaje:
<img width="965" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/8fb4e805-5d66-43fb-9b62-37efbe6256d2">

Al continuar y finalizar, aparecerá esto despues de darle click a "OK"
haremos click en Close y cerraremos el navegador
<img width="958" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/c4d1278b-c830-493f-bb40-3a80bc5c75e0">

Al ingresar al SAP Management Console (sapmmc.msc) deberemos ver algo de la siguiente forma:<BR>
<img width="247" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/4e469ce5-3fa6-4a83-989d-564e6da9374b">

## Product Catalog

En caso de que sapinst no arranque de forma directa, podremos especificar de forma explícita que cargue el xml con el siguiente comando:

sapinst.exe SAPINST_CONTROL_URL=product.catalog.xml

## No connect to database, session terminated

En caso de intentar acceder a la instancia y que devuelva este mensaje, podremos revisar el log de la consola MMC
encontraremos errores del tipo "SAP Basis System: Error in DB rollback/SyFlush, return code  000256" o "Database: SQL error 30046  occurred; work process in reconnect status",
podremos solucionar esto reiniciando los servicios de Sybase a través de la services.msc y reintentar abrir el servidor desde el SAPGUI.
Con reiniciar el servicio Sybase SQLServer _ SID debería bastar para permitir que la instancia vuelva a conectar hacia la base de datos, caso contrario reiniciar la instancia.

## DBACOCKPIT - OBJECTS_OBJREF_NOT_ASSIGNED Dump [Notas 17-03-2025]

Se requiere instalar una nota o support package en el sistema afectado

Workaround (no es solución permanente):

Ingresar a transacción SM30<br>
![image](https://github.com/user-attachments/assets/fc2a5685-98ab-4c99-aee1-640574401ba3)

y cambiar el timezone para que coincida con el sistema:<br>

![image](https://github.com/user-attachments/assets/fa523038-ec41-4905-941e-9bd3d6c8c3b7)<br>

Ingresar los siguiente parámetros al perfil de instancia (RZ11)

```
icm/host_name_full = sapsrv
icm/server_port_0 = PROT=HTTP,PORT=80$$,PROCTIMEOUT=600,TIMEOUT=600
icm/server_port_1 = PROT=HTTPS,PORT=443$$,PROCTIMEOUT=600,TIMEOUT=600
login/create_sso2_ticket = 2
login/accept_sso2_ticket = 1
```

La ultima edición funcional del perfil de instancia quedó asi (22/03/2025):

![image](https://github.com/user-attachments/assets/3a5e7206-13c3-4785-941e-0e16dc2aec44)


Reiniciar AS y servicio de instancia

## Configurar ST03N:

JOB SAP_COLLECTOR_FOR_PERFMONITOR:
![image](https://github.com/user-attachments/assets/c57300f0-fb07-4232-b489-57eb8ab93178)

![image](https://github.com/user-attachments/assets/7e9ffc0c-1ee1-4dfd-8523-cb946afe98f5)


Para obtener los datos de forma constante de la carga de los WP configurados, se debe crear un job por medio de la SM37 con los siguientes datos:

```
JOB NAME: SAP_COLLECTOR_FOR_PERFMONITOR
STEP:   RSCOLL00
USUARIO: CON PERMISOS POR ROL en OBJETOS S_BTCH_ADM (*), S_BTCH_JOB (PLAN, RELE) y S_BTCH_NAM (*)
CONDICION: PERÍODICA (Hourly)
```

## Error 403 web dynpros

Por medio de la transaccion SICF
Activar los siguientes servicios:

![image](https://github.com/user-attachments/assets/073f5ed2-050c-4ffd-ab46-f3bace9e5044)
![image](https://github.com/user-attachments/assets/473ff3b6-1998-4427-976e-e8b6a6b8b84a)

```
sap/public/bc
sap/public/bc/ur
sap/bc/webdynpro/sap/DBA_COCKPIT
```

## Crear un certificado SSL

Ingresaremos a la transacción STRUST<br>
Nos posicionaremos en "SSL server Standard"<br>
Elegimos CREATE del menu contextual, cambiamos el nombre para identificarlo<br>
y hacemos click en el tick verde. <br>
En caso de que ya existiera, elegimos Replace en cambio de querer reemplazarlo cuando esté vencido.<br>

![image](https://github.com/user-attachments/assets/873a63a5-7b64-4d4d-8196-e83b982f1083)

En caso de querer agregarlo al Certificate List, usaremos el boton de "Add to Certificate list"<br>

![image](https://github.com/user-attachments/assets/cff82687-a184-4722-9fc3-33fc4896f3bc)

Con el programa SSF_ALERT_CERTEXPIRE podremos en el futuro ver si expiran 

![image](https://github.com/user-attachments/assets/6889f907-4aa6-4326-b5f8-8de7302a6405)

En la siguiente carpeta encontraremos los archivos PSE:

```
C:\usr\sap\NSP\DVEBMGS00\sec
```

![image](https://github.com/user-attachments/assets/c45e6f5f-053e-4baf-ac1d-6186c0d91998)


## SWNC_TCOLL_STARTER - No authorization for transaction ST07

Vamos a crear un ROL llamado Z_BATCH_USER_TRANSACTIONS, le vamos a agregar las siguientes autorizaciones:

![image](https://github.com/user-attachments/assets/00c19a55-38a1-47da-9739-cb125aeae05c)

```
S_ADMI_FCD
S_CCM_RECV
S_RZL_ADM
```

Nos quedará de esta forma con los datos completados:

![image](https://github.com/user-attachments/assets/77dbf1ba-0ee5-4881-b1cd-672a80da2284)

```
S_ADMI_FCD: ST0R
S_CCM_RECV: Activity P0 (Accept CCMS CSM data)
S_RZL_ADM: Activity 03 (Display / Visualizar)
```

Ahora agregaremos una mas llamadada S_CTS_SADM

![image](https://github.com/user-attachments/assets/e0ddae2e-1fc5-4072-88e8-8ff063467ff9)

E iremos completando los campos con los datos requeridos

![image](https://github.com/user-attachments/assets/1e4a868a-f5bc-440c-ac46-8c96936d0ed8)

```CTS_ADMFCT: TABL```

y en Domain y DESTSYS lo llenaremos de acuerdo a nuestro sistema, por ejemplo en este caso el sistema es NSP por lo que se completara de esta forma:

![image](https://github.com/user-attachments/assets/a573bc1f-c68a-456d-915a-2f6ba0deb627)

De cualquier forma, para los permisos podremos hacer un STAUTHTRACE sobre el usuario que asignamos al job y tomar de ahi los valores que esta buscando. 

Y luego filtraremos por el resultado 12 / No authorization in user master record

Procederemos una vez realizado el mantenimiento de las autorizaciones a generar el perfil, y transportaremos el perfil en caso de ser necesario. 
para liberar la orden utilizaremos la transaccion SE01 e importarla en el otro cliente / sistema.

En caso de ser entre clientes es posible que se deba marcar "Ignore Non-Pemitted Table Class" para evitar un error por el tipo de clase de tablas.
Luego asignaremos el rol al usuario por medio de SU01

## IPV4 

En caso de tener la VM configurada como red puente en lugar de NAT, deberemos usar o bien la IPV4 o bien desactivar la IPV6
en la máquina virtual para permitir que SAPGUI pueda comunicarse al servidor

Una vez configurado, setearemos la entrada en SAPGUI e ingresaremos para comprobar que nos podemos comunicar al servidor:

<img width="575" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/40512319-79c4-4c4a-b2be-fd98c1d699bf">

## Resource temporarily unavailable (partner x:3200 not reached)

En caso de reiniciar el servidor, es posible que tenga que ejecutar de nuevo el .ps1 para abrir los puertos asignados a sapgui
(incluso tras cambiar de NAT a Adaptador Puente)

En caso de haber desactivado el ipv6 se debe usar el hostname para comunicarse, o dominio completo en caso de que el router haya
asignado de esa forma la comunicación.

Se debería poder hacer persistente ejecutando esto despues del script (no probado)
(puede requerir agregar un -Enabled True al script):

```
Set-NetFirewallRule -DisplayName "SAP Inbound" -Enabled True
Set-NetFirewallRule -DisplayName "SAP Outbound" -Enabled True
```


## CPU timers not synchronized. Check note 1036194

<img width="660" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/daea5d02-5d3c-4d81-8b7a-5bf82fbd1d31">

En el primer inicio, nos puede salir un error de ABAP que nos pida que ejecutemos la transacción SICK
al ejecutarla nos advierte que debemos solucionar el problema antes de usar el servidor y nos da un error como
"CPU timers not synchronized. Check note 1036194"

El problema puede ser solucionado si entramos al SAP Management Console y reiniciamos la instancia completa de SAP
En caso de no quedar persistente ejecutar el siguiente comando en cmd y reiniciar:

```bcdedit /set {current} useplatformclock true```

Si en el futuro necesitamos acceder al error que figuró, podremos ejecutar la transacción ST22 

## A RAISE statement in program "CL_GUI_HTML_VIEWER============CP" has raised exception condition "CNTL_ERROR".

Este problema sucede al intentar ejecutar un comando de una transacción que requiera el uso del navegador de sistema
pero no se puede realizar.<br>
<img width="662" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/35e1a73e-a0f4-42ad-b03c-ce8e5ca73541"><br>

Al no poder mostrar el contenido en el navegador, se realiza una excepción en el programa:<br>
<img width="649" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/5e631b09-d5e4-4806-b263-ab7df94dc2bd"><br>

La solución se encuentra investigando, puede deberse a una falta de instalación de Java en el sistema.

## CREAR NUEVO CLIENTE:

Primero ejecutar la RZ10, importar los perfiles y editar login/no_automatic_user_sapstar cambiando el valor a 0
Después en la SCC4, crear un nuevo cliente, en caso de no tener un logical system creado, obviar el campo.
Despues reiniciar el servidor sap desde el sapmmc. 

Loguear con SAP*, contraseña PASS

## Reiniciar instancia sin usar sapmmc

Abrir la consola cmd y ejecutar. reemplazar SID por la id de sap y password por la contraseña del usuario de administrador

```
cd S:\usr\sap\<SID>\SYS\exe\uc\NTAMD64
sapcontrol -nr 00 -user Administrator <password> -function Stop
sapcontrol -nr 00 -user Administrator <password> -function Start
```

## [FIX] no default co. address has been maint. in the system. create an address:

<img width="600" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/f0eb7b4b-5eed-454d-ad72-b486c3b90d46">

```comp-readme.txt```

Se necesita crear una dirección de compañía a través de la transacción SUCOMP para poder configurar<br>
el TMS en el cliente 000, sino dirá "Could not create user TMSADM" y no avanzará.<br>

Ingresaremos a la transacción SUCOMP, pondremos un nombre y haremos click en el botón de "Create"<br>
<img width="487" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/e4d8f179-6480-46e0-975f-5a5aeeb0e883"><br>

Llenaremos los datos obligatorios:<br>
nota: sap verificará la consistencia de algunos datos por lo que hay datos que tienen que ser correctos<br>
<img width="554" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/eefb7779-1a07-42b4-bf90-8f6c6e6c8b4f">

Si todo va bien nos dirá "Address data was saved"<br>

**NOTA: A partir de este punto, la creación de un usuario es opcional y basta con seleccionar como "Standard Address"
para poder configurar el STMS**

Si ingresamos a los usuarios del sistema por SU01, veremos que no tienen asignada una compañía:<br>
<img width="608" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/3f77d61b-d1bb-41c8-8446-c001d0515691"><br>

A través de la SU10 podremos asignar la nueva compañía a todos los usuarios que hayamos elegido:<br>

<img width="609" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/f86813eb-4d4d-44fe-9d22-bbda637c8be3"><br>

Tener en cuenta las posibles advertencias que salgan:<br>
<img width="696" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/fac3a7b8-a5b2-4ba0-a458-817c4f49d2a9"><br>

En caso de querer asignar la dirección y no querer modificar los campos requeridos, podremos hacer una copia del usuario:<br>
Lo haremos a través de la transacción SU01:<br>
<img width="443" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/b23be335-872f-4530-95b4-1e3bdb566d29"><br>

Al copiar el usuario, nos saldrán advertencias similares a estas:<br>
<img width="631" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/c8be65b4-044f-4ff7-a638-3a620aa23a99"><br>

Guardaremos el usuario, llenaremos apellido y nombre cuando nos requiera y asignaremos una compañía.<br>
Luego, a través de la SUCOMP, definiremos a la compañía que creamos como "Standard Adress":<br>
<img width="571" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/94948070-4844-4381-80c8-c7975b377d85"><br>

Volveremos a repetir el proceso de STMS para crear el DOMAIN y TMS y ya debería salir este mensaje al terminar:<br>
<img width="555" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/e757dbe6-a8d7-4e9d-a7aa-4785bc49c612"><br>

## FIX: Address doesn't exist 22787 / SAP note 1420281

Entrar a SE16N, y escribir la tabla ADRC
Escribir /H y presionar Enter en el campo de comandos para activar el modo depuración.
Presionar F8
Estaremos en la Screen 100/19 of program SAPLSE16N
En DESKTOP 3 podremos agregar variables a la sesión,
Escribiremos los siguientes valores y presionamos enter:

![image](https://github.com/user-attachments/assets/f95eb5e4-d7bd-46e2-abf8-d5d9bc706c09)

Cambiaremos ambos valores a X (El valor hexadecimal cambiara a 5800)
Presionamos F8 y podremos editar la tabla para agregar el campo que faltaba:

![image](https://github.com/user-attachments/assets/e56a2c47-308f-4518-a806-3fe4ddca7fbc)

Guardaremos los datos con el ícono de guardado y regresaremos a SUCOMP para editar o borrar la company como querramos.
Es recomendable igualmente eliminar el registro y crearlo de cero para que sea más limpio.

## STMS Configurar ruta de transporte local entre clientes 000 y 001

Logueados en el cliente 000, vamos a "Transport Routes"
Agregamos un single system y configuramos de la siguiente forma:<br>
<img width="461" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/8988efb0-6738-4f8e-bb2d-d68c8f428b8b"><br>
<img width="459" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/4359dcae-6ffb-4721-9a53-9c305e42b5c2"><br>

Es importante tambien configurar la ruta como "Consolidation" y el Target system/client en <ID>.001 con Transport Layer en SAP.
Esto puede ser configurado desde el menú de Edit. Tener en cuenta que una vez activada la ruta, las opciones aparecerán en gris.

Es importante elegir bien el target a la hora de crear las órdenes o se harán como "Local Change Requests" y no se pasarán al otro cliente.
En caso de que el check diga "System <sid> has transport routes, but no standard layer for it" se puede ignorar.

## Salir de transacción si no funciona la opción de detener transacción:

Ejecutar /osm04

Podremos cerrar las sesiones seleccionandolas y haciendo click en "Delete Session"<br>
![image](https://github.com/dev-lang/sap_time/assets/56205122/7456e90a-44a4-46e8-8273-2f69351e15d8)<br>

Tener en cuenta que esto puede provocar el cierre abrupto de tareas activas, usar con cuidado

## table class is 'C'. Entries are only imported to client '000'

Al intentar realizar un transporte de roles, nos pueden aparecer estos errores:<br>
<img width="912" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/7dc4608a-86a1-48a5-8178-dc6114d410c8"><br>

Algo que podemos hacer para pasar este error a modo de workaround es marcar la siguiente opción antes de importar:<br>
<img width="442" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/0380cc1e-d613-4efc-8e31-2179bed62dc9"><br>

Podemos ver que ahora logra importar la OT al cliente/mandante:<br>
<img width="712" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/5ec22d5f-0dfe-44f3-944c-9e0235898eff"><br>

Igual deberemos comprobar, en este caso por la transacción PFCG si el rol o componente fue impactado correctamente

## Client 000 has status 'not modifiable'

<img width="508" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/975fddc2-7db6-404e-aa3e-18ec03e9d6b1"><br>

En caso de que nos salga este error (por ejemplo en la transacción OBD4)<br>
podremos cambiar de forma temporal el status de modificable a través de la transacción SE06:<br>

<img width="516" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/7e558cc5-34df-4d10-b00b-cedc3d4318b4"><br>
Dentro de "system change option" podremos modificar los parámetros:<br>
<img width="654" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/68a57150-4add-4976-8c8a-125fc5f72c53"><br>

Podremos escoger entre los siguientes estados:<br>
<img width="621" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/f01e1639-18ce-47d4-8532-ef0deae4cac8"><br>

En la transacción SCC4 podremos ver los clientes (mandantes) del sistema:<br>
<img width="515" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/bb841a81-7133-40a8-9ed0-cd63dd33745e"><br>

## The data is locked by user ... and can be displayed only.

Si nos aparece este mensaje al intentar ingresar a una tabla o transacción, <br>
podremos ejecutar la transacción SM04 para así desbloquear el acceso.<br>
<img width="559" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/29ff8a10-b029-4f3d-be6a-ff77d6d6dbac">



## Transporte de OTs entre clientes

A través de la SE38, ejecutaremos RSTRANSP para el transporte de variantes.
Luego a través de la transacción SE10 deberíamos poder liberarla.

## System unknown in Transport Management System

En caso de que aparezca este error al hacer un Add manualmente, se debe hacer sin establecer un target client.
Después de agregar la orden a la cola de stms, se debe agregar, no en el mismo momento de añadirla


## SU25 - PFCG (Autorizaciones)

![image](https://github.com/dev-lang/sap_time/assets/56205122/93ac9cd8-ea8f-4a12-a49a-26047ca887c3)

Deberemos ejecutar SU25 en caso de ser necesario.

## Tracear autorizaciones pendientes sin SU53:

-Podremos utilizar STAUTHTRACE para setear un trace a un usuario para asignarle los objetos y autorizaciones<br>
al rol asociado a un usuario por medio de PFCG. 

## SM36 User && is not authorized to schedule program && as a background job

El usuario de BATCH necesita autorizaciones de acuerdo al Authorization Group del programa que necesitamos ejecutar.<br>
En la transacción SE38 podremos revisar esto haciendo un Display al Subobjet Attributes:<br>

![image](https://github.com/user-attachments/assets/4ae271bd-36b2-4437-a9ba-c037fa1d64a1)

Identificado el valor, que en este caso es SSAA, procederemos a agregarlo a un rol existente o nuevo:

![image](https://github.com/user-attachments/assets/2c8a34e8-719a-45db-bfdd-a608a0df6ee1)

En caso de querer importarlo por una Orden de Transporte, recordar marcar "Ignore Non-Permitted Table Class" si llega a dar error.

![image](https://github.com/user-attachments/assets/f9dea9ae-3a06-42b5-943f-56f5d0749aff)

Una vez preparado el ROL en el sistema, procederemos a agregarlo por medio de la transacción SU01 y probaremos a agregar el paso al job:

![image](https://github.com/user-attachments/assets/812a030d-0463-4f45-ac82-ce3c1ade0f14)

Si no da error, ya tenemos permisos para schedulear un job con un Z con authorizations SSAA

## RENOVAR LICENCIA / HABILITAR DEVELOPER KEY

Las vms creadas desde los instaladores TRIAL ofrecidos por SAP, deberan crear una licencia tanto para ampliar el tiempo
como para habilitar el acceso a la transacción SE38:

https://go.support.sap.com/minisap/#/minisap

La licencia deberá ser reemplazada por medio de la transacción SLICENSE.

## ACTIVAR SAP SCRIPTING:
Temporal: RZ11
sapgui/user_scripting 

Permanente: RZ10
https://success.panaya.com/docs/how-to-set-server-parameters-to-enable-gui-scripting-server-side

## Actualizar Kernel (Notas)
Se ha probado actualizar el kernel desde 720_EXT a 722_EXT con éxito.
Algunas cosas a tener en cuenta:

+ se debe detener la instancia de sap desde MMC o con el siguiente comando:

```
cd C:\usr\sap\NSP\DVEBMGS00\exe
sapcontrol -user Administrator password -nr 00 -function StopSystem >> C:\sapcontrolstop.log
```

+ crear una copia de la carpeta C:\usr\sap\NSP\SYS\exe\uc\NTAMD64
+ los servicios se deben establecer en MANUAL antes de detenerlos
+ recien ahi se deben detener los servicios:
```
	-SAPDAA_97
	-SAPNSP_00
	-SAPHostExec
	-SAPHostControl
```
+ descomprimir los .SAR directamente puede llevar a inconsistencias entre los archivos<br>
es recomendable ejecutar:

```
sapcar -xvf SAPEXE_1400-70000603.SAR -R kernel
sapcar -xvf SAPEXEDB_1400-70000608.SAR -R kerneld
```

+ una vez que la instancia y los servicios estén detenidos, podremos copiar los archivos de kernel y kerneld en C:\usr\sap\NSP\SYS\exe\uc\NTAMD64 - copy
+ renombrar la carpeta ORIGINAL a NTAMD64-OLD
+ renombrar la carpeta NTAMD64 - copy a NTAMD64
+ iniciar los servicios:
```
	-SAPDAA_97
	-SAPNSP_00
	-SAPHostExec
	-SAPHostControl
```
+ reiniciar la instancia desde MMC o con el siguiente comando:

```
cd C:\usr\sap\NSP\DVEBMGS00\exe
sapcontrol -user Administrator password -nr 00 -function StartSystem >> C:\sapcontrolstart.log
```

+ volver a poner en automático los servicios que pasamos a MANUAL:

```
	-SAPDAA_97
	-SAPNSP_00
	-SAPHostExec
```

> **💡 Nota importante:** De salir el WARNING de "Running but Dialog Queue info unavailable” deberemos:

+ detener la instancia y servicios
+ (opcional pero importante) revisar que C:\usr\sap\NSP\DVEBMGS00\exe tenga los mismos cambios que NTAMD64
+ ir a c:\windows\system32 y comprobar la version de sapstartsrv.exe
+ de ser diferente a 7220.XXXX.XX.XXXXX, renombrar a sapstartsrv.exe.720
+ copiar el ejecutable nuevo desde la carpeta kernel y pegarla en c:\windows\system32
+ reiniciar servicios e instancia

Nota: en la operatoria de prueba no afectó al funcionamiento de la instancia pero aun asi es algo a tener en cuenta
para que sea consistente la actualización.

> **✅ Consejo:** comprobar que aparezca todo en verde con un mensaje como <br>
"Running, Message Server connection ok, Dialog Queue time: 0.00 sec"

+ LISTO! con comprobar SICK y la version de SAP Kernel en sm51 ya alcanza para saber que se realizó correctamente.


## Referencias:
https://abapacademy.com/blog/category/how-to-install-free-sap/sap-nw-as-750-installation/

https://aancos.com/2017/05/12/sap-gui-for-windows-7-50/

unzip para SAP_ECC6_EHP6_Source:<br>
https://sourceforge.net/projects/gnuwin32/files/unzip/5.51-1/unzip-5.51-1-bin.zip/download?use_mirror=sitsa&download=

Otras referencias útiles:<br>

http://sapbasisinfo.com/<br>
https://www.sapbasiseasy.com/<br>
https://www.saptechnicalguru.com/<br>
https://www.se80.co.uk/<br>
