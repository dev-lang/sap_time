# ComputerName
$ComputerName = "sapsrv"
Rename-Computer -NewName $ComputerName -Force

# Memoria Virtual (swap)
$PageFileSizeMB = 20500

# Desactivar asignación automática
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "C:\pagefile.sys $($PageFileSizeMB) $($PageFileSizeMB) 0 0"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1

# Reiniciar para aplicar cambios
Restart-Computer -Force
