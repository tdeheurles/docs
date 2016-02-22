#! /bin/bash
echo -e "\e[92mInstalling VirtualBox utils\e[39m"
sudo apt-get install -y \
  virtualbox-guest-dkms \
  virtualbox-guest-utils \
  virtualbox-guest-x11
