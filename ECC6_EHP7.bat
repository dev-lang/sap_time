mkdir 51048312
mkdir 51049350_KERNEL
mkdir 51050177_ORACLE12
mkdir SWPM10SP09
move 51049350_*.rar 51049350_KERNEL
move 51048312_*.* 51048312
move Oracle12.1.0.2_client_51050177.ZIP 51050177_ORACLE12
copy unzip.exe "51050177_ORACLE12\unzip.exe"
cd 51048312
start /wait 51048312_part01.exe /s
del 51048312_*.*
cd ..
cd 51050177_ORACLE12
unzip Oracle12.1.0.2_client_51050177.ZIP
del Oracle12.1.0.2_client_51050177.ZIP
del unzip.exe
cd..
unzip "Software Provisioning Manager 1.0 SP 09.zip" -d SWPM10SP09
del "Software Provisioning Manager 1.0 SP 09.zip"
copy unrar.exe "51049350_KERNEL\unrar.exe"
cd 51049350_KERNEL
unrar x 51049350_SAP_Kernel_7.42_Windows_Server_x64_64bit.part1.rar
del *.rar
del unrar.exe
cd ..
7z x "51049350_KERNEL\51049350_SAP_Kernel_7.42_Windows_Server_x64_64bit\51049350_10.zip" -o51049350_KERNEL
rmdir "51049350_KERNEL\51049350_SAP_Kernel_7.42_Windows_Server_x64_64bit" /S /Q
pause
