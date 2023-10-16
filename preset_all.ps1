# ComputerName
$ComputerName = "sapsrv"
Rename-Computer -NewName $ComputerName -Force

# Memoria Virtual (swap)
$PageFileSizeMB = 20500

# Mostrar extensiones de archivo
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

# Mostrar ocultos y archivos del sistema
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1

# Desactivar asignación automática
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "C:\pagefile.sys $($PageFileSizeMB) $($PageFileSizeMB) 0 0"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1

# abrir puerto TCP3200 para permitir conexiones al servidor (sapgui)
# en virtualbox configurar port-forwarding
New-NetFirewallRule -DisplayName "SAP Inbound" -Direction Inbound -LocalPort 3200 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SAP Outbound" -Direction Outbound -LocalPort 3200 -Protocol TCP -Action Allow

# Desactivar UAC
# Ultimo paso previo a instalar EHP6
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "EnableLUA"
$regValue = 0
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue

# Reiniciar para aplicar cambios
Restart-Computer -Force
