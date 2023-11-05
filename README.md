# sap_time
Scripts varios para preparar un sistema SAP

Acerca de byebyetimer: es un script para evitar que la VM de SAP sincronice la hora con el host
en aquellos sistemas con licencia vencida, puede servir para continuar utilizando sap.

### LEER READMES INCLUIDOS EN CASO DE PRESENTAR PROBLEMAS CON VBS
scripts probados en SAP GUI, en caso de presentar fallas instalar gui750_11-80001468.exe

# NOTAS DE INSTALACIÓN:

1. Se debe instalar el OS elegido (se ha probado Win2016 para ECC6 EHP6 y Win2012 R2 para ECC EHP8)
2. Ejecutar el preset correspondiente
3. Verificar que se hayan instalado los pre-requisitos necesarios (puede requerirse un seteo de PATH en caso de instalar Java)
4. Copiar los archivos de instalación en un disco aparte
5. Copiar el archivo .bat correspondiente
   (por ejemplo, para SAP ECC6 EHP8 bajo Win2012R2 se requiere una estructura así:
   <img width="469" alt="image" src="https://github.com/dev-lang/sap_time/assets/56205122/8a75964a-8010-4a8b-88b7-39a4b145877a">
6. Ejecutar .BAT y seguir las instrucciones y notas de este README

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
| ECC6_EHP8.bat                    | Prepara la instalación de ECC6 EHP8                                      |
| comp-readme.txt                  | Notas sobre el Código de la Compañía y PFCG                               |
| byebyetimer.bat                  | Desactiva la configuración de hora y realiza varias configuraciones para SAP Netweaver en Windows Server 2003 |
| Linux_Ubuntu-1810.sh             | Prepara sistema Linux para SAP (Script parcial) |

## Linux SAP (Ubuntu 18.10):

Seguir instrucciones de guía:
https://blogs.sap.com/2022/11/14/sap-netweaver-as-abap-developer-edition-installation-pitfalls/<BR>
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

ref:
https://abapacademy.com/blog/category/how-to-install-free-sap/sap-nw-as-750-installation/

https://aancos.com/2017/05/12/sap-gui-for-windows-7-50/

unzip para SAP_ECC6_EHP6_Source: https://sourceforge.net/projects/gnuwin32/files/unzip/5.51-1/unzip-5.51-1-bin.zip/download?use_mirror=sitsa&download=
