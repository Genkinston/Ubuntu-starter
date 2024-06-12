#!/bin/bash
#Установка софта для работы виртуальных машин
sudo nala install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox
sudo usermod -aG libvirt,kvm,vboxusers "$USER"
newgrp libvirt
newgrp kvm
newgrp vboxusers 
#Установка прочего софта
sudo nala install -y gdebi curl htop btop neofetch bpytop clang cargo copyq libc6-i386 libc6-x32 libu2f-udev samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer.0-vaapi corectrl rpi-imager distrobox filezilla