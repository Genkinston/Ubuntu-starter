#!/bin/bash
set -e

update () {
  #Обновляем систему
  sudo apt update && sudo apt upgrade -y
  sudo snap refresh
  if [[ -x "/usr/bin/flatpak" ]]; then
    flatpak update
  fi
  printf "\n====================\nDONE\n====================\n"
}

base_soft () {
  #Установка пакета кодеков мультимедия ubuntu-restricted-extras
  sudo apt install -y ubuntu-restricted-extras
  #Настраиваем контекстное меню файлового менеджера Nautilus
  sudo apt install -y nautilus-admin exe-thumbnailer
  #Устанавливаем дополнительную поддержку архиваторов
  sudo apt install -y p7zip-rar rar unrar unace arj cabextract
  #Устанавливаем программы для работы с пакетами
  sudo apt install -y gdebi
  #Устанавливаем инструмент GNOME Tweaks для настройки рабочего окружения
  sudo apt install -y gnome-tweaks
  #Устанавливаем расширения рабочего окружения Gnome
  sudo apt install -y chrome-gnome-shell gnome-shell-extensions gnome-shell-extension-manager
  #Поддержка принтеров и сканеров
  sudo apt install -y gcc libtool libssl-dev libc-dev libjpeg-turbo8-dev libpng-dev libtiff5-dev cups printer-driver-gutenprint
  #Установка библиотек помогающий в работе python
  sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev pkg-config make
  printf "\n====================\nDONE\n====================\n"
}

extra_soft () {
  #Установка прочего софта
  sudo apt install -y gdebi curl htop btop bpytop clang cargo copyq libc6-i386 libc6-x32 samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer1.0-vaapi corectrl rpi-imager distrobox filezilla
  printf "\n====================\nDONE\n====================\n"
}

flatpak_install () {
  #Включаем поддержку приложений Flatpak. Подключаем репозиторий Flathub и устанавливаем Центр приложений Gnome
  sudo apt install -y flatpak gnome-software-plugin-flatpak gnome-software && sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #Установка прочего софта flatpak
  sudo flatpak install -y flathub org.telegram.desktop
#  sudo flatpak install -y flathub org.videolan.VLC
#  без впн не устанавливается
  sudo flatpak install -y flathub com.github.tchx84.Flatseal
  printf "\n====================\nDONE\n====================\n"
}

games_soft () {
  sudo dpkg --add-architecture i386
  sudo apt update
  sudo apt install -y steam-installer steam-devices lutris
  printf "\n====================\nDONE\n====================\n"
}

appimage_soft () {
  deb_link="https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb"
  pool_link="https://github.com/prateekmedia/appimagepool/releases/download/5.1.0/appimagepool-5.1.0-x86_64.AppImage"
  deb_AppImageLauncher="appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb"
  pkg_AppImagePool="appimagepool-5.1.0-x86_64.AppImage"
  #Установка AppImageLauncher
  if [[ ! -x "/usr/bin/appimagelauncherd" ]]; then
    wget "$deb_link" && \
    sudo apt install -y "./$deb_AppImageLauncher" && \
    rm -f "./$deb_AppImageLauncher"
  fi
  #Установка AppImagePool
  mkdir -p ~/Applications
  if [[ ! -f ~/Applications/"$pkg_AppImagePool" ]]; then
    wget "$pool_link" && \
    mv "$pkg_AppImagePool" ~/Applications/ && \
    chmod +x ~/Applications/"$pkg_AppImagePool"
  fi
  printf "\n====================\nDONE\n====================\n"
}

vm_soft () {
  #Установка софта для работы виртуальных машин
  sudo apt install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox gnome-boxes
  sudo usermod -aG libvirt,kvm,vboxusers "$USER"
  printf "\nNeed reboot or use 'newgrp libvirt kvm vboxusers'\n"
  printf "\n====================\nDONE\n====================\n"
}

docker_install () {
  if [[ ! -x "/usr/bin/docker" ]]; then
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sudo sh get-docker.sh && \
    rm -f get-docker.sh && \
    sudo usermod -aG docker "$USER"
  else
    printf "\n====================\n\nDocker already installed\n\n====================\n"
  fi
}

programming_soft () {
  # Установка ПО для программирования
  if ! command -v code >/dev/null 2>&1; then
    sudo apt-get install -y wget gpg

    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
    rm -f microsoft.gpg

    sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

    sudo apt update
    sudo apt install -y code ansible ansible-lint
  fi

  printf "\n====================\nDONE\n====================\n"
}

while true; do
  printf "\n--------------------------\n"
  printf "[0] update system\n"
  printf "[1] base soft\n"
  printf "[2] extra soft\n"
  printf "[3] flatpak and soft\n"
  printf "[4] games\n"
  printf "[5] appimage\n"
  printf "[6] virtual machine soft\n"
  printf "[7] docker cli\n"
  printf "[8] programming\n"
  printf "%s\n" "--------------------------"
  printf "[ALL] install all software scripts\n"
  printf "[9] exit\n"
  read -r -n 3 -p "Select script for install: " script

  case $script in
  0)
    update
    ;;
  1)
    base_soft
    ;;
  2)
    extra_soft
    ;;
  3)
    flatpak_install
    ;;
  4)
    games_soft
    ;;
  5)
    appimage_soft
    ;;
  6)
    vm_soft
    ;;
  7)
    docker_install
    ;;
  8)
    programming_soft
    ;;
  all | ALL)
    update
    base_soft
    extra_soft
    flatpak_install
    games_soft
    appimage_soft
    vm_soft
    docker_install
    programming_soft
    ;;
  9)
    printf '\n\n'
    printf '    ░░░░░░░░▀████▀▄▄░░░░░░░░░░░░░░▄█\n'
    printf '    ░░░░░░░░░░█▀░░░░▀▀▄▄▄▄▄░░░░▄▄▀▀█\n'
    printf '    ░░▄░░░░░░░░█░░░░░░░░░░▀▀▀▀▄░░▄▀\n'
    printf '    ░▄▀░▀▄░░░░░░▀▄░░░░░░░░░░░░░░▀▄▀\n'
    printf '    ▄▀░░░░█░░░░░█▀░░░▄█▀▄░░░░░░▄█\n'
    printf '    ▀▄░░░░░▀▄░░█░░░░░▀██▀░░░░░██▄█\n'
    printf '    ░▀▄░░░░▄▀░█░░░▄██▄░░░▄░░▄░░▀▀░█\n'
    printf '    ░░█░░▄▀░░█░░░░▀██▀░░░░▀▀░▀▀░░▄▀\n'
    printf '    ░█░░░█░░█░░░░░░▄▄░░░░░░░░░░░▄▀\n'
    exit 0
    ;;
  *)
    echo "Invalid option: $script"
    ;;
  esac
done
