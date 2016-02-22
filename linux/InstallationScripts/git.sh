#! /bin/bash
echo -e "\e[92mInstalling Git\e[39m"
if [[ $# != 2 ]]; then
  echo "Usage, give :"
  echo " 1- gituser"
  echo " 2- gitmail"
  echo " "
  exit 1
fi

gituser=$1
gitmail=$2

sudo apt-get install -y git

git config --global user.name $gituser
git config --global user.email $gitmail
git config --global push.default simple
