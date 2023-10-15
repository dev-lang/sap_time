# abrir puerto TCP3200 para permitir conexiones al servidor (sapgui)
# en virtualbox configurar port-forwarding
New-NetFirewallRule -DisplayName "SAP Inbound" -Direction Inbound -LocalPort 3200 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SAP Outbound" -Direction Outbound -LocalPort 3200 -Protocol TCP -Action Allow
