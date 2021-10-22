
@echo off
title SAP
color 1F

set password=password2
set dd=13
set mm=07
set aaaa=2011
set sapstart="C:\Program Files\Cracklock\Bin\MCL.exe" "C:\USR\SAP\NSP\SYS\EXE\UC\NTI386\SAPSTART.EXE"

echo Deteniendo Temporalmente servicio de SAP
net stop SAPNSP_00
echo Estableciendo contraseña %password% a usuario
net user Administrator %password%
echo Estableciendo fecha a 13 de julio de 2011
date %mm%/%dd%/%aaaa%
echo Desactivando servicio de timesync (w32time)
sc config w32time start= disabled
echo Deteniendo servicio de timesync (w32time)
net stop w32time
echo Reiniciando servicio de SAP 
net start SAPNSP_00
echo Abriendo SAP
echo cuando abra debe iniciar sap
echo si la solicita, la contraseña es %password%

%sapstart%

: OPCIONAL (Habilitar temas visuales)

sc config Themes start= auto
net start Themes

pause
