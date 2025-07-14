#!/bin/bash
set -e
apt install -y curl 
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | tee /etc/apt/sources.list.d/prebuilt-mpr.list

wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
apt install -y ./steam.deb prismlauncher lutris
rm -f ./steam.deb

echo -e "\n====================\nDONE\n====================\n"

exit 0

