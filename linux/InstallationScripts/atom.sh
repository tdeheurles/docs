#! /bin/bash
echo -e "\e[92mInstalling atom.io\e[39m"
URL='https://atom.io/download/deb'
FILE=`mktemp`
sudo apt-get install -y \
  git \
  gconf2 \
  gconf-service \
  libgtk2.0-0 \
  libnotify4 \
  libxtst6 \
  libnss3 \
  gvfs-bin \
  xdg-utils

wget $URL -qo $FILE && sudo dpkg -i $FILE; rm $FILE
