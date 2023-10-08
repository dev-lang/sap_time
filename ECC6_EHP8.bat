cd "ECC6 EHP8 Exports"
start /wait 51050708_part1.exe /s
del 51050708_part1.exe
del *.rar
cd ..
cd "SWPM"
sapcar -xvf *.*
del SWPM10SP38_1-20009707.SAR
sapinst.exe SAPINST_GUI_HOSTNAME=10.0.2.15
