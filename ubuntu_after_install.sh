#!/bin/bash
#Обновляем систему
sudo apt update && sudo apt dist-upgrade -y
sudo snap refresh
#Установка пакета кодеков мультимедия ubuntu-restricted-extras
sudo apt install ubuntu-restricted-extras -y
#Настраиваем контекстное меню файлового менеджера Nautilus
apt-cache search nautilus
sudo apt install nautilus-admin exe-thumbnailer -y
nautilus -q
#Устанавливаем дополнительную поддержку архиваторов
sudo apt install p7zip-rar rar unrar unace arj cabextract -y
#Устанавливаем программы для работы с пакетами
sudo apt install synaptic gdebi  -y
#Устанавливаем инструмент GNOME Tweaks для настройки рабочего окружения
sudo apt install gnome-tweaks -y
#Устанавливаем консольный мониторинг ресурсов Btop
sudo apt install btop -y
#Включаем поддержку приложений Flatpak. Подключаем репозиторий Flathub и устанавливаем Центр приложений Gnome
sudo apt install -y flatpak gnome-software-plugin-flatpak gnome-software -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#Устанавливаем расширения рабочего окружения Gnome
sudo apt install -y chrome-gnome-shell gnome-shell-extensions gnome-shell-extension-manager
#Поддержка принтеров и сканеров
sudo apt install -y gcc libtool libssl-dev libc-dev libjpeg-turbo8-dev libpng-dev libtiff5-dev cups printer-driver-gutenprint
#Установка софта для работы виртуальных машин
sudo apt install -y virt-manager qemu-system libvirt-daemon-system qemu-utils
sudo usermod -aG libvirt,kvm "$USER"
newgrp libvirt
newgrp kvm
#Установка прочего софта apt
sudo apt install -y nala gdebi curl htop neofetch bpytop clang cargo libc6-i386 libc6-x32 libu2f-udev samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer1.0-vaapi corectrl rpi-imager distrobox
#Установка прочего софта flatpak
sudo flatpak install -y flathub com.ultimaker.cura 
sudo flatpak install -y flathub com.heroicgameslauncher.hgl
sudo flatpak install -y flathub ru.yandex.Browser
sudo flatpak install -y flathub org.telegram.desktop
sudo flatpak install -y flathub com.valvesoftware.Steam
sudo flatpak install -y flathub com.discordapp.Discord
sudo flatpak install -y flathub com.vscodium.codium
sudo flatpak install -y flathub org.prismlauncher.PrismLauncher
sudo flatpak install -y flathub org.videolan.VLC
sudo flatpak install -y flathub org.gnome.Boxes
sudo flatpak install -y flathub io.github.dvlv.boxbuddyrs
sudo flatpak install -y flathub com.github.tchx84.Flatseal

#Установка docker
./dockerinstall.sh

