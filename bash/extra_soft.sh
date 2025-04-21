#!/bin/bash
set -e
#Установка прочего софта
apt install -y gdebi curl htop btop neofetch bpytop clang cargo copyq libc6-i386 libc6-x32 libu2f-udev samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer1.0-vaapi corectrl rpi-imager distrobox filezilla steam-devices lutris
snap install code --classic

echo -e "\n====================\nDONE\n====================\n"

exit 0

