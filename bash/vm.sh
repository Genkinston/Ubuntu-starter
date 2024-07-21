#!/bin/bash
set -e
#Установка софта для работы виртуальных машин
nala install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox gnome-boxes
usermod -aG libvirt,kvm,vboxusers "$SUDO_USER"

echo "Need reboot or use 'newgrp libvirt kvm vboxusers'"

echo -e "\n====================\nDONE\n====================\n"

exit 0
