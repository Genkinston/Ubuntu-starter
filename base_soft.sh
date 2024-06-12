#!/bin/bash
set -e
#Установка пакета кодеков мультимедия ubuntu-restricted-extras
nala install -y ubuntu-restricted-extras
#Настраиваем контекстное меню файлового менеджера Nautilus
nala install -y nautilus-admin exe-thumbnailer
#Устанавливаем дополнительную поддержку архиваторов
nala install -y p7zip-rar rar unrar unace arj cabextract
#Устанавливаем программы для работы с пакетами
nala install -y synaptic gdebi
#Устанавливаем инструмент GNOME Tweaks для настройки рабочего окружения
nala install -y gnome-tweaks
#Устанавливаем расширения рабочего окружения Gnome
nala install -y chrome-gnome-shell gnome-shell-extensions gnome-shell-extension-manager \
#Поддержка принтеров и сканеров
nala install -y gcc libtool libssl-dev libc-dev libjpeg-turbo8-dev libpng-dev libtiff5-dev cups printer-driver-gutenprint \
#Установка библиотек помогающий в работе python
nala install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev pkg-config make \

echo -e "\n====================\nDONE\n====================\n"

exit
