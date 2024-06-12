#!/bin/bash
set -e
#Установка софта для работы виртуальных машин
nala install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox
usermod -aG libvirt,kvm,vboxusers "$SUDO_USER"
newgrp libvirt kvm vboxusers

echo -e "\n====================\nDONE\n====================\n"

exit 0
