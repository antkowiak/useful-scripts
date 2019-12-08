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


if [[ $EUID -ne 0 ]];
then
    exec sudo /bin/bash "$0" "$@"
fi

function check_reboot_needed()
{
    if [ -f /var/run/reboot-required ]
        then
        echo "Reboot Required"
        exit
    fi
}

check_reboot_needed
apt -y update

check_reboot_needed
apt -y upgrade

check_reboot_needed
apt -y dist-upgrade

check_reboot_needed
apt -y autoremove

check_reboot_needed
apt -y clean

check_reboot_needed

lsb_release -a
uname -a

