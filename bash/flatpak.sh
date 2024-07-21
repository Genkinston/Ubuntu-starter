#!/bin/bash
set -e
#Включаем поддержку приложений Flatpak. Подключаем репозиторий Flathub и устанавливаем Центр приложений Gnome
nala install -y flatpak gnome-software-plugin-flatpak gnome-software -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#Установка прочего софта flatpak
flatpak install -y flathub com.ultimaker.cura 
flatpak install -y flathub com.heroicgameslauncher.hgl
flatpak install -y flathub ru.yandex.Browser
flatpak install -y flathub org.telegram.desktop
flatpak install -y flathub com.valvesoftware.Steam
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.vscodium.codium
flatpak install -y flathub org.prismlauncher.PrismLauncher
flatpak install -y flathub org.videolan.VLC
flatpak install -y flathub io.github.dvlv.boxbuddyrs
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y io.github.shiftey.Desktop
echo -e "\n====================\nDONE\n====================\n"

exit
