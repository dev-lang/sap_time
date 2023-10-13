# sap_time
Scripts varios para preparar un sistema SAP

Acerca de byebyetimer: es un script para evitar que la VM de SAP sincronice la hora con el host
en aquellos sistemas con licencia vencida, puede servir para continuar utilizando sap.

### LEER READMES INCLUIDOS EN CASO DE PRESENTAR PROBLEMAS CON VBS
scripts probados en SAP GUI, en caso de presentar fallas instalar gui750_11-80001468.exe

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


## PORT FORWARDING (solo NAT)

En caso de realizar NAT, es requerido un port forwarding para poder comunicar 
el cliente local con el servidor de la vm<br>
<img width="614" alt="NAT PF" src="https://github.com/dev-lang/sap_time/assets/56205122/cbe364b3-c364-4927-a936-6eb7d78db660"><br>

Para el resto de los servicios se deberá hacer lo mismo

NOTA: Es recomendable usar un puente en lugar de NAT, si se utiliza una máquina host diferente al cliente 
o si se desea permitir varios clientes o que la vm tome el dominio (p.e: sapprd.dominio.com.ar)

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
