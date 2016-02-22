#! /bin/bash
echo -e "\e[92mInstalling docker\e[39m"
wget -qO- https://get.docker.com/ | sh  # dl & install
sudo adduser `whoami` docker            # adduser to docker group to remove sudo need

if [[ -n `which systemctl` ]]; then
  sudo systemctl enable docker            # enable
fi
