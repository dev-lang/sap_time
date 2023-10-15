# código adaptado para windows server 2008
# ComputerName
$ComputerName = "sapsrv"
Rename-Computer -NewName $ComputerName -Force

# Mostrar extensiones de archivo
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

# Mostrar ocultos y archivos del sistema
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1

# Memoria Virtual (swap)
$PageFileSizeMB = 20500

# Desactivar asignación automática
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "C:\pagefile.sys $($PageFileSizeMB) $($PageFileSizeMB) 0 0"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1

# Desactivar UAC
# Ultimo paso previo a instalar EHP6
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "EnableLUA"
$regValue = 0
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue

# Reiniciar para aplicar cambios
Restart-Computer -Force
