#!/bin/bash
set -e
#Установка прочего софта
nala install -y gdebi curl htop btop neofetch bpytop clang cargo copyq libc6-i386 libc6-x32 libu2f-udev samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer1.0-vaapi corectrl rpi-imager distrobox filezilla

echo -e "\n====================\nDONE\n====================\n"

exit 0

