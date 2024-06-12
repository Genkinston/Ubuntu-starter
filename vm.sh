#!/bin/bash
#Установка софта для работы виртуальных машин
sudo nala install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox
sudo usermod -aG libvirt,kvm,vboxusers "$USER"
newgrp libvirt
newgrp kvm
newgrp vboxusers 