#!/bin/bash
echo
echo
echo "###################################################################"
echo "# https://github.com/FastDigitalOceanDroplets/Transmission-Client #"
echo "###################################################################"
echo

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Set the locale on your computer (is not the smartest way, I accept sugestions to do it interactivily)
export LC_ALL=en_US.UTF-8
export LANG="en_US.UTF-8"
export LANGUAGE=en_US.UTF-8
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
dpkg-reconfigure locales

# Change time zone at your new server
dpkg-reconfigure tzdata

# Update all
apt -y update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove
apt -y install transmission-cli transmission-common transmission-daemon

# ---------- Configurar Transmission ----------
service transmission-daemon stop
curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/FastDigitalOceanDroplets/Transmission-Client/master/settings.json > /var/lib/transmission-daemon/info/settings.json
#sudo nano /var/lib/transmission-daemon/info/settings.json

# sed -i 's+++g' /var/lib/transmission-daemon/info/settings.json

# Crear un directorio incomplete
# sed -i 's+"incomplete-dir": "/var/lib/transmission-daemon/Downloads"+"incomplete-dir": "/var/lib/transmission-daemon/Downloads/incomplete"+g' /var/lib/transmission-daemon/info/settings.json

# Habilitar directorio de incompletos
# sed -i 's+"incomplete-dir-enabled": false+"incomplete-dir-enabled": true+g' /var/lib/transmission-daemon/info/settings.json


service transmission-daemon start
