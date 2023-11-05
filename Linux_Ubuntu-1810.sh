#!/bin/bash

# Change the hostname
sudo hostnamectl set-hostname vhcalnplci

# Comprobar si sources.list.bak ya existe
if [ -e /etc/apt/sources.list.bak ]; then
    # Encontrar el próximo número de secuencia disponible
    count=1
    while [ -e /etc/apt/sources.list.bak-$count ]; do
        ((count++))
    done

    # Hacer una copia de respaldo con el formato sources.list.bak-###
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak-$count
else
    # Si sources.list.bak no existe, hacer una copia de respaldo normal
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
fi

# Reemplazar 'archive' con 'old-releases' solo en líneas que no están comentadas
sudo sed -Ei '/^#/! s#http://([a-z]+\.)?archive\.ubuntu\.com#http://old-releases.ubuntu.com#g' /etc/apt/sources.list

# Actualizar las listas de paquetes
sudo apt-get update
sudo apt-get upgrade

# Desactivar firewall
sudo ufw disable

# Instalar SSH
sudo apt-get install openssh-server
