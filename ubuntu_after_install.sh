#!/bin/bash
#Обновляем систему
sudo apt update && sudo apt upgrade -y
sudo snap refresh

echo -e "\n====================\nBase soft install\n===================="

while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
    #Установка Flatpak и софта
    bash ./base_soft.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done

echo -e "\n====================\nExtra soft install\n===================="

while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
    #Установка Flatpak и софта
    bash ./extra_soft.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done

echo -e "\n====================\nFlatpak soft install\n===================="

while true; do
  read -r -n 1 -p "Continue or Skip? (c|s) " cs
  case $cs in
  [Cc]*)
    #Установка Flatpak и софта
    bash ./flatpak.sh
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
    bash ./git.sh
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
    bash ./dockerinstall.sh
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
    bash ./yandexdisk.sh
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
    bash ./prismlauncher.sh
    ;;
  [Ss]*)
    echo -e "\n"
    break
    ;;
  *) echo -e "\nPlease answer C or S!\n" ;;
  esac
done

