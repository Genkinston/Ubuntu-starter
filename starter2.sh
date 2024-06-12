#!/bin/bash
#Обновляем систему
sudo apt update && sudo apt upgrade -y
sudo snap refresh

while true; do
  echo -e "\n--------------------------\n"
  echo -e "[1] base soft\n"
  echo -e "[2] extra soft\n"
  echo -e "[3] flatpak and soft\n"
  echo -e "[4] git\n"
  echo -e "[5] prism launcher\n"
  echo -e "[6] yandex disk\n"
  echo -e "--------------------------\n"
  read -r -n 1 -p "Select script for install: " script

  case $script in

  # установим node-exporter
  1)
    bash ./base_soft.sh
    ;;
  2)
    bash ./extra_soft.sh
    ;;
  3)
    bash ./flatpak.sh
    ;;    
  4)
    bash ./git.sh
    ;;  
  5)
    bash ./pairmlaucher.sh
    ;;
  6)
    bash ./yandexdisk.sh
    ;;
  esac
done