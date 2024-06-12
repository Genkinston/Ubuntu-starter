#!/bin/bash
set -e
#Установка софта для работы виртуальных машин
nala install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox
usermod -aG libvirt,kvm,vboxusers "$SUDO_USER"
echo
echo 'Use "newgrp libvirt kvm vboxuser" or reboot for apply changes'

echo -e "\n====================\nDONE\n====================\n"

exit 0
