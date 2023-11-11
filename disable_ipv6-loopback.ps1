# Deshabilitar IPv6 globalmente en Windows Server 2012

# Verificar si el script se está ejecutando con privilegios administrativos
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Por favor, ejecuta este script como administrador."
    exit
}

# Deshabilitar IPv6 en todas las interfaces de red
Get-NetAdapter | ForEach-Object {
    Disable-NetAdapterBinding -Name $_.Name -ComponentID "ms_tcpip6"
}

# Deshabilitar IPv6 en la interfaz de bucle (loopback)
$loopback = Get-NetAdapter | Where-Object { $_.InterfaceAlias -eq 'Loopback Pseudo-Interface 1' }
if ($loopback) {
    Disable-NetAdapterBinding -InputObject $loopback -ComponentID "ms_tcpip6"
    Write-Host "IPv6 ha sido deshabilitado en la interfaz de bucle."
} else {
    Write-Host "No se encontró la interfaz de bucle."
}

Write-Host "IPv6 ha sido deshabilitado en todas las interfaces de red."
