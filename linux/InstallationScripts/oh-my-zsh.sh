#! /bin/bash
echo -e "\e[92mInstalling Oh-My-Zsh\e[39m"
if [[ $# != 1 ]]; then
  echo "Usage, give :"
  echo " 1- account password"
  echo " "
  exit 1
fi

password=$1

sudo apt-get install -y zsh wget

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
mv ~/.zshrc  ~/.zshrc.bkp
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
echo $password | chsh -s /bin/zsh
