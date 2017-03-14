#!/usr/bin/env bash
#
# This file is copyright under the latest version of the EUPL.
# Please see LICENSE file for your rights under this license.

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use the root user to install the software."
    exit 1
fi

clear && clear

# Installation 
apt-get update && apt-get upgrade -y
echo ""; set "132" "134"; FONCTXT "$1" "$2"; echo -e "${CBLUE}$TXT1${CEND}${CGREEN}$TXT2${CEND}"; echo ""

apt-get install -y \
	wirehark \
	gnome-shell \
	konsole \
	xterm \
	git \
	curl \
	nano 

echo ""; set "156" "134"; FONCTXT "$1" "$2"; echo -e "${CBLUE}$TXT1${CEND}${CGREEN}$TXT2${CEND}"; echo ""

# Download && unpack
cd /tmp

wget -cqO https://github.com/netkit-ng/netkit-ng-core/releases/download/3.0.4/netkit-ng-core-32-3.0.4.tar.bz2 
wget -cqO https://github.com/netkit-ng/netkit-ng-build/releases/download/0.1.3/netkit-ng-filesystem-i386-F7.0-0.1.3.tar.bz2 
wget -cqO https://github.com/netkit-ng/netkit-ng-build/releases/download/0.1.3/netkit-ng-kernel-i386-K3.2-0.1.3.tar.bz2 

tar -xjSf netkit-ng-core-32-3.0.4.tar.bz2 | progress  -m  $!
tar -xjSf netkit-ng-filesystem-i386-F7.0-0.1.3.tar.bz2 | progress  -m  $!
tar -xjSf netkit-ng-kernel-i386-K3.2-0.1.3.tar.bz2 | progress  -m  $!

echo ""; set "156" "134"; FONCTXT "$1" "$2"; echo -e "${CBLUE}$TXT1${CEND}${CGREEN}$TXT2${CEND}"; echo ""

# Export
export NETKIT_HOME=/home/$NETKIT_HOME/netkit‑ng
export MANPATH=$MANPATH:$NETKIT_HOME/man
export PATH=$PATH:$NETKIT_HOME/bin

# Check if configuration is ok

chmod u+x check_configuration.sh
 ./check_configuration.sh
vstart sta1
