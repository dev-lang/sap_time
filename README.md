# sap_time
Scripts varios para preparar un sistema SAP

Acerca de byebyetimer: es un script para evitar que la VM de SAP sincronice la hora con el host
en aquellos sistemas con licencia vencida, puede servir para continuar utilizando sap.

### LEER READMES INCLUIDOS EN CASO DE PRESENTAR PROBLEMAS CON VBS
scripts probados en SAP GUI, en caso de presentar fallas instalar gui750_11-80001468.exe

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
