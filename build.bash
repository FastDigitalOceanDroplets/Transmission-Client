#!/bin/bash
echo
echo
echo "###################################################################"
echo "# https://github.com/FastDigitalOceanDroplets/Transmission-Client #"
echo "#                                                              #"
echo "# We will go though the proccess of setting up a full BitTorrent"
echo "# BitTorrent "
echo "# a fantastic easy and smart to use control panel called Vesta.#"
echo "#                                                              #"
echo "#   Vesta is free, but you can get paid help at their site.    #"
echo "#                    https://vestacp.com                       #"
echo "################################################################"
echo

# Prevents doing this from other account than root
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

apt update
apt upgrade
apt install transmission-cli transmission-common transmission-daemon

# ---------- Configurar Transmission ----------
service transmission-daemon stop
#sudo nano /var/lib/transmission-daemon/info/settings.json

# sed -i 's+++g' /var/lib/transmission-daemon/info/settings.json

# Crear un directorio incomplete
sed -i 's+"incomplete-dir": "/var/lib/transmission-daemon/Downloads"+"incomplete-dir": "/var/lib/transmission-daemon/Downloads/incomplete"+g' /var/lib/transmission-daemon/info/settings.json

# Habilitar directorio de incompletos
sed -i 's+"incomplete-dir-enabled": false+"incomplete-dir-enabled": true+g' /var/lib/transmission-daemon/info/settings.json


##################################
# Change xxxx
while true
do
 	read -s  -p "Enter a new VestaCP admin password: " adminpass1
 	echo
 	read -s  -p "Enter the new VestaCP admin password again: " adminpass2
	echo
	if  [[ -z "$adminpass1" ]] && [[ -z "$adminpass2" ]]
	then
		echo "Passwords can't be empty. Try again."
		echo
	else
		if [ $adminpass1 != $adminpass2 ]
		then
			echo "Passwords are not identical. Try again."
			echo
 		else
 			echo "Password accepted."
 			echo
			break
		fi
	fi
done
/usr/local/vesta/bin/v-change-user-password admin $adminpass1

service transmission-daemon stop
