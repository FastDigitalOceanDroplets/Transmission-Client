!#/bin/bash
apt update
apt upgrade
apt install transmission-cli transmission-common transmission-daemon

# ---------- Configurar Transmission ----------
service transmission-daemon stop
#sudo nano /var/lib/transmission-daemon/info/settings.json

service transmission-daemon stop
