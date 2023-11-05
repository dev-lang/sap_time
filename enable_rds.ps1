# Activar escritorio remoto
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Start-Service -Name TermService
Set-Service -Name TermService -StartupType Automatic
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
