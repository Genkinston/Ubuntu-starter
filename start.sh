#!/bin/bash
set -e
#Установка nala для ускорения работы apt
sudo apt install nala -y
#Обновляем систему
sudo nala update && sudo nala upgrade -y
sudo snap refresh

while true; do
  echo -e "\n--------------------------\n"
  echo -e "[1] base soft\n"
  echo -e "[2] extra soft\n"
  echo -e "[3] flatpak and soft\n"
  echo -e "[4] git\n"
  echo -e "[5] prism launcher\n"
  echo -e "[6] yandex disk\n"
  echo -e "[7] virtual machine soft\n"
  echo -e "[8] docker cli\n"
  echo -e "--------------------------\n"
  echo -e "[0] exit\n"
  read -r -n 1 -p "Select script for install: " script

  case $script in

  1)
    sudo bash ./base_soft.sh
    ;;
  2)
    sudo bash ./extra_soft.sh
    ;;
  3)
    sudo bash ./flatpak.sh
    ;;    
  4)
    sudo bash ./git.sh
    ;;  
  5)
    sudo bash ./prismlauncher.sh
    ;;
  6)
    sudo bash ./yandexdisk.sh
    ;;
  7)
    sudo bash ./vm.sh
    ;;
  8)
    sudo bash ./dockerinstall.sh
    ;;
  0)
    echo -e "\n\nOK\n"
    exit 0
    ;;
  esac
done