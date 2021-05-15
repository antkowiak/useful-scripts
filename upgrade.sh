#!/bin/bash
#
# This script automates all of the command line commands necessary
# to perform software and security updates on an Ubuntu system.
# It does not update to new major/distro versions though.
# The instructions for updates to a new major distro are as follows:
#
# To Upgrade to a new distro, run this script, then
# 1) apt install update-manager-core
# 2) do-release-upgrade
#
#
# Created by Ryan Antkowiak (antkowiak@gmail.com)
#

COLOR_INVERSE="\e[7m"
COLOR_DEFAULT="\e[0m"

UPGRADE_LIST=""

if [[ $EUID -ne 0 ]];
then
    exec sudo /bin/bash "$0" "$@"
fi

function print_upgrade_list()
{
    if [[ ! -z "${UPGRADE_LIST}" ]]
    then
        echo -e "Upgrade List: ${COLOR_INVERSE}${UPGRADE_LIST}${COLOR_DEFAULT}"
    fi
}

function check_reboot_needed()
{
    if [ -f /var/run/reboot-required ]
        then
        print_upgrade_list
        echo -e "${COLOR_INVERSE}Reboot Required${COLOR_DEFAULT}"
        exit
    fi
}


check_reboot_needed
apt -y update

UPGRADE_LIST=`apt list --upgradable 2>/dev/null |grep -v "Listing..." |cut -f1 -d'/' |tr '\n' ' '  |sed 's/ *$//'`

check_reboot_needed
apt -y upgrade

check_reboot_needed
apt -y dist-upgrade

check_reboot_needed
apt -y autoremove

check_reboot_needed
apt -y clean

check_reboot_needed

print_upgrade_list
lsb_release -a
uname -a

