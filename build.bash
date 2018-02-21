!#/bin/bash
apt update
apt upgrade
apt install transmission-cli transmission-common transmission-daemon

# ---------- Configurar Transmission ----------
service transmission-daemon stop
# 
