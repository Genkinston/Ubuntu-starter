#!/bin/bash
#Обновляем систему
sudo apt update && sudo apt dist-upgrade -y
sudo snap refresh
#Установка nala для ускорения работы apt
sudo apt install nala
#Установка пакета кодеков мультимедия ubuntu-restricted-extras
sudo nala install ubuntu-restricted-extras -y
#Настраиваем контекстное меню файлового менеджера Nautilus
nala-cache search nautilus
sudo nala install nautilus-admin exe-thumbnailer -y
nautilus -q
#Устанавливаем дополнительную поддержку архиваторов
sudo nala install p7zip-rar rar unrar unace arj cabextract -y
#Устанавливаем программы для работы с пакетами
sudo nala install synnalaic gdebi  -y
#Устанавливаем инструмент GNOME Tweaks для настройки рабочего окружения
sudo nala install gnome-tweaks -y
#Устанавливаем консольный мониторинг ресурсов Btop
sudo nala install btop -y
#Устанавливаем расширения рабочего окружения Gnome
sudo nala install -y chrome-gnome-shell gnome-shell-extensions gnome-shell-extension-manager
#Поддержка принтеров и сканеров
sudo nala install -y gcc libtool libssl-dev libc-dev libjpeg-turbo8-dev libpng-dev libtiff5-dev cups printer-driver-gutenprint
#Установка библиотек помогающий в работе python
sudo nala install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev pkg-config make
#Установка софта для работы виртуальных машин
sudo nala install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox
sudo usermod -aG libvirt,kvm,vboxusers "$USER"
newgrp libvirt
newgrp kvm
newgrp vboxusers 
#Установка прочего софта nala
sudo nala install -y gdebi curl htop neofetch bpytop clang cargo copyq libc6-i386 libc6-x32 libu2f-udev samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer1.0-vaapi corectrl rpi-imager distrobox filezilla

echo -e "\n====================\nFlatpak soft install\n===================="

while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
    #Установка Flatpak и софта
    ./flatpak.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done
echo -e "\n====================\nGit install\n===================="

while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
    #Установка Git Cli и Git Desktop
    ./git.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done

echo -e "\n====================\nDocker install\n===================="


while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
#Установка docker
./dockerinstall.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done


echo -e "\n====================\nYandex disk install\n===================="


while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
#Установка сетевого диска Yandex
./yandexdisk.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done

echo -e "\n====================\nPrism Laucher install\n===================="

while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
#Установка Prism Laucher
./prismlauncher.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done

