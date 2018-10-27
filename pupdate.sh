#!/bin/bash

TICK="[\e[32m ✔ \e[0m]"

echo -e " \e[1m This script will download and update @mc9662 adlists.list \e[0m"
sleep 1
echo -e "\n"

if [ "$(id -u)" != "0" ] ; then
        echo "This script requires root permissions. Please run this as root!"
        exit 2
fi
echo -e " ${TICK} \e[32m Backing Up adlists.list to /etc/pihole/adlists.list.bak \e[0m"
cp /etc/pihole/adlists.list /etc/pihole/adlists.list.bak
echo -e " ${TICK} \e[32m Downloading @mc9662 adlists.list! \e[0m"
list="$(grep "^(\^|.*\$$" /etc/pihole/adlists.list)"
list+="
$(wget -qO - https://raw.githubusercontent.com/mc9662/pihole/master/adlists.list)"
LC_COLLATE=C sort -u <<< "$list" | grep -v "^#" | grep -v '^[[:space:]]*$' | sudo tee /etc/pihole/adlists.list
wait
echo -e " ${TICK} \e[32m Pi-hole's adlist updated \e[0m"
echo -e " ${TICK} \e[32m Done! \e[0m"
pihole --regex ^wpad.lan
exit

