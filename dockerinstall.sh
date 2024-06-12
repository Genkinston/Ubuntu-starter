#!/bin/bash
set -e
# Add Docker's official GPG key:
apt install nala
nala update
install -y ca-certificates curl
nala install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
nala update
nala install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker "$USER"
newgrp docker
kill -15 $PPID
systemctl enable docker
systemctl start docker
systemctl restart docker


echo -e "\n====================\nDONE\n====================\n"

exit



