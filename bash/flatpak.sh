#!/bin/bash
set -e
#Включаем поддержку приложений Flatpak. Подключаем репозиторий Flathub и устанавливаем Центр приложений Gnome
apt install -y flatpak gnome-software-plugin-flatpak gnome-software -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#Установка прочего софта flatpak
flatpak install -y flathub org.telegram.desktop
flatpak install -y flathub org.videolan.VLC
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y io.github.shiftey.Desktop
echo -e "\n====================\nDONE\n====================\n"

exit
