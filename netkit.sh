#!/usr/bin/env bash
#
# This file is copyright under the latest version of the EUPL.
# Please see LICENSE file for your rights under this license.
# Tested on Ubuntu 16.04 GNOME

# Check if user is root
if [ $(id -u) != "0" ]; then
	echo "Error: You must be root to run this script, please use the root user to install the software."
        exit 1
fi

sleep 2

# Setting locale function 
function _locale() {
	echo 'LANGUAGE="fr_FR.UTF-8"' >> /etc/default/locale
	echo 'LC_ALL="fr_FR.UTF-8"' >> /etc/default/locale
	echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen
  if [[ -e /usr/sbin/locale-gen ]]; then locale-gen 
  else
  
apt-get -y update && apt-get install locales -y
    locale-gen
    export LANG="fr_FR.UTF-8"
    export LC_ALL="fr_FR.UTF-8"
    export LANGUAGE="fr_FR.UTF-8"
  fi
}

sleep 2

# Uninstall Iptables
apt-get autoremove --purge iptables -y

echo "Iptables purged!"

sleep 4

# Setting local packages 
cd / && apt-get update && apt-get dist-upgrade -y 2>&1

apt-get install -y wirehark gnome-shell konsole xterm git curl nano systemd-sysv software-properties-common python-software-properties 2>&1

echo "Updating OS System done !"

sleep 4

# Download | Unpack Netkit componants 
cd /opt/

wget -cqO https://github.com/netkit-ng/netkit-ng-core/releases/download/3.0.4/netkit-ng-core-32-3.0.4.tar.bz2 
	&& tar -xjSf netkit-ng-core-32-3.0.4.tar.bz2 2>&1
	
wget -cqO https://github.com/netkit-ng/netkit-ng-build/releases/download/0.1.3/netkit-ng-filesystem-i386-F7.0-0.1.3.tar.bz2 
	&& tar -xjSf netkit-ng-filesystem-i386-F7.0-0.1.3.tar.bz2 2>&1
	
wget -cqO https://github.com/netkit-ng/netkit-ng-build/releases/download/0.1.3/netkit-ng-kernel-i386-K3.2-0.1.3.tar.bz2 
	&& tar -xjSf netkit-ng-kernel-i386-K3.2-0.1.3.tar.bz2 tar 2>&1
	
	
echo "Netkit installed"

sleep 4

# Export
export NETKIT_HOME=/home/$NETKIT_HOME/netkit‑ng
export MANPATH=$MANPATH:$NETKIT_HOME/man
export PATH=$PATH:$NETKIT_HOME/bin

sleep 2

# Check if configuration is ok

chmod u+x check_configuration.sh
bash ./check_configuration.sh

vstart sta1

echo "Vstart started!"

sleep 4

exit
