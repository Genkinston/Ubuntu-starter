#!/bin/bash
set -e
#Включаем поддержку приложений Flatpak. Подключаем репозиторий Flathub и устанавливаем Центр приложений Gnome
sudo nala install -y flatpak gnome-software-plugin-flatpak gnome-software -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
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
sudo flatpak install -y io.github.shiftey.Desktop
echo -e "\n====================\nDONE\n====================\n"

exit
