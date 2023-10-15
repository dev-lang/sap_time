# Desactivar UAC
# Ultimo paso previo a instalar EHP6
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "EnableLUA"
$regValue = 0
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue

# Reiniciar para aplicar cambios
Restart-Computer -Force
