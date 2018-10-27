#!/bin/bash

if [ "$(id -u)" != "0" ] ; then
	echo "This script requires root permissions. Please run this as root!"
	exit 2
fi

apt update
apt upgrade
./mmotti.sh
./pupdate.sh
./whitelist/scripts/whitelist.sh
./padd.sh

