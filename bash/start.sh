#!/bin/bash
set -euo pipefail

LOG_FILE="/tmp/ubuntu-starter-$(date +%Y%m%d-%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1
printf "Log: %s\n\n" "$LOG_FILE"

GREEN='\033[32m'
RED='\033[31m'
YELLOW='\033[33m'
NC='\033[0m'

check_sudo() {
  if [[ $EUID -eq 0 ]]; then
    printf "${RED}Run this script as a regular user, not root${NC}\n"
    exit 1
  fi
  if ! sudo -v; then
    printf "${RED}Sudo access required${NC}\n"
    exit 1
  fi
}

check_internet() {
  if ! ping -c1 -W2 google.com &>/dev/null; then
    printf "${YELLOW}No internet connection detected${NC}\n"
    return 1
  fi
}

confirm() {
  printf "\n%s [Y/n]: " "$1"
  read -r -n 1 reply
  echo
  [[ "$reply" =~ ^[Yy]?$ ]]
}

update () {
  check_internet || return
  sudo apt update && sudo apt upgrade -y
  sudo snap refresh
  if [[ -x "/usr/bin/flatpak" ]]; then
    flatpak update
  fi
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

base_soft () {
  check_internet || return
  sudo apt install -y debconf-utils
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
  echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections
  sudo DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-restricted-extras
  sudo apt install -y nautilus-admin exe-thumbnailer
  sudo apt install -y p7zip-rar rar unrar unace arj cabextract
  sudo apt install -y gdebi
  sudo apt install -y gnome-tweaks
  sudo apt install -y chrome-gnome-shell gnome-shell-extensions gnome-shell-extension-manager
  sudo apt install -y gcc libtool libssl-dev libc-dev libjpeg-turbo8-dev libpng-dev libtiff5-dev cups printer-driver-gutenprint
  sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev pkg-config make
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

extra_soft () {
  check_internet || return
  sudo apt install -y gdebi curl htop btop bpytop clang cargo copyq libc6-i386 libc6-x32 samba-common-bin exfat-fuse default-jdk curl wget unrar linux-headers-"$(uname -r)" linux-headers-generic git gstreamer1.0-vaapi corectrl rpi-imager distrobox filezilla
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

flatpak_install () {
  confirm "Install Flatpak and applications?" || return
  check_internet || return
  sudo apt install -y flatpak gnome-software-plugin-flatpak gnome-software && sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install -y flathub org.telegram.desktop
#  sudo flatpak install -y flathub org.videolan.VLC
#  без впн не устанавливается
  sudo flatpak install -y flathub com.github.tchx84.Flatseal
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

games_soft () {
  confirm "Install games software?" || return
  check_internet || return
  sudo dpkg --add-architecture i386
  sudo apt update
  sudo apt install -y steam-installer steam-devices lutris
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

appimage_soft () {
  check_internet || return
  deb_link="https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb"
  pool_link="https://github.com/prateekmedia/appimagepool/releases/download/5.1.0/appimagepool-5.1.0-x86_64.AppImage"
  deb_AppImageLauncher="appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb"
  pkg_AppImagePool="appimagepool-5.1.0-x86_64.AppImage"
  if [[ ! -x "/usr/bin/appimagelauncherd" ]]; then
    wget "$deb_link" && \
    sudo apt install -y "./$deb_AppImageLauncher" && \
    rm -f "./$deb_AppImageLauncher"
  fi
  mkdir -p ~/Applications
  if [[ ! -f ~/Applications/"$pkg_AppImagePool" ]]; then
    wget "$pool_link" && \
    mv "$pkg_AppImagePool" ~/Applications/ && \
    chmod +x ~/Applications/"$pkg_AppImagePool"
  fi
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

vm_soft () {
  confirm "Install VM software?" || return
  check_internet || return
  sudo apt install -y virt-manager qemu-system libvirt-daemon-system qemu-utils virtualbox gnome-boxes
  sudo usermod -aG libvirt,kvm,vboxusers "$USER"
  printf "\n${YELLOW}Need reboot or use 'newgrp libvirt kvm vboxusers'${NC}\n"
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

docker_install () {
  confirm "Install Docker?" || return
  check_internet || return
  if [[ ! -x "/usr/bin/docker" ]]; then
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sudo sh get-docker.sh && \
    rm -f get-docker.sh && \
    sudo usermod -aG docker "$USER"
  else
    printf "\n====================\n${YELLOW}Docker already installed${NC}\n====================\n"
  fi
}

programming_soft () {
  confirm "Install programming tools?" || return
  check_internet || return
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
  printf "\n====================\n${GREEN}DONE${NC}\n====================\n"
}

if [[ $# -gt 0 ]]; then
  for arg in "$@"; do
    case $arg in
      --help|-h)
        printf "Usage: bash start.sh [OPTION]\n\nOptions:\n"
        printf "  --update|0       Update system\n"
        printf "  --base|1         Install base software\n"
        printf "  --extra|2        Install extra software\n"
        printf "  --flatpak|3      Install Flatpak and apps\n"
        printf "  --games|4        Install games\n"
        printf "  --appimage|5     Install AppImage support\n"
        printf "  --vm|6           Install VM software\n"
        printf "  --docker|7       Install Docker\n"
        printf "  --programming|8  Install programming tools\n"
        printf "  --all            Install everything\n"
        printf "  --help, -h       Show this help\n"
        exit 0 ;;
    esac
  done
  check_sudo
  for arg in "$@"; do
    case $arg in
      --help|-h) ;;
      --update|0) update ;;
      --base|1) base_soft ;;
      --extra|2) extra_soft ;;
      --flatpak|3) flatpak_install ;;
      --games|4) games_soft ;;
      --appimage|5) appimage_soft ;;
      --vm|6) vm_soft ;;
      --docker|7) docker_install ;;
      --programming|8) programming_soft ;;
      --all)
        update; base_soft; extra_soft; flatpak_install
        games_soft; appimage_soft; vm_soft
        docker_install; programming_soft ;;
      9) exit 0 ;;
      *)
        printf "${RED}Unknown option: %s${NC}\n" "$arg"
        printf "Use --help for usage\n"
        exit 1 ;;
    esac
  done
  exit 0
fi

check_sudo

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
  read -r -n 3 -p "Select script for install: " script || true
  script=${script:-}

  case $script in
  0) update ;;
  1) base_soft ;;
  2) extra_soft ;;
  3) flatpak_install ;;
  4) games_soft ;;
  5) appimage_soft ;;
  6) vm_soft ;;
  7) docker_install ;;
  8) programming_soft ;;
  all|ALL)
    update; base_soft; extra_soft; flatpak_install
    games_soft; appimage_soft; vm_soft
    docker_install; programming_soft ;;
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
    exit 0 ;;
  *) printf "${RED}Invalid option: $script${NC}\n" ;;
  esac
done
