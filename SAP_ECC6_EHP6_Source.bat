unzip NW_7.03_Kernel_7.20_EXT_Sybase_ASE.zip
unzip NW_7.03_Kernel_7.20_EXT_Sybase_ASE_Unicode.zip
del NW_7.03_Kernel_7.20_EXT_Sybase_ASE.zip
del NW_7.03_Kernel_7.20_EXT_Sybase_ASE_Unicode.zip
cd ECC6_EHP6_Export
start /wait 51041989_part01.exe /s
cd ..
copy SAPCAR_1211-80000938.EXE "SWPM 1.0 NW 7.0\sapcar.exe"
cd "SWPM 1.0 NW 7.0"
del SWPM10SP24_7-20009707
del SWPM10SP24_7-20009707.sar
sapcar -xvf *.*
del 70SWPM10SP03_4-20009707
del 70SWPM10SP03_4-20009707.sar
sapinst.exe
