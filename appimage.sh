#!/bin/bash
set -e

#Установка AppImageLauncher
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo nala install -y ./appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
rm ./appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
mkdir ~/Applications
#Установка AppImagePool
wget https://github.com/prateekmedia/appimagepool/releases/download/5.1.0/appimagepool-5.1.0-x86_64.AppImage && mv appimagepool-5.1.0-x86_64.AppImage ~/Applications
