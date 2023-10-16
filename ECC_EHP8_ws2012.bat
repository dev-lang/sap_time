EHP8 Exports"
start /wait 51050708_part1.exe /s
del 51050708_part1.exe
del *.rar
cd ..
cd "SAP ASE DB"
sapcar.exe -xvf *.SAR
cd ..
cd "SWPM"
sapcar -xvf *.*
del SWPM10SP38_1-20009707.SAR
sapinst.exe
