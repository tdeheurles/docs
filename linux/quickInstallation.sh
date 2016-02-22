if [[ $# != 2 ]]; then
  echo "Usage, give :"
  echo " 1- gituser"
  echo " 2- gitmail"
  echo " "
  exit 1
fi


# Quick installation of some usefull package
gituser=$1
gitmail=$2

prompt_green()  { echo " " ; echo -e "\e[92m$1\e[39m" }

download_and_install(){
  FILE=`mktemp`; wget "$1" -qo $FILE && sudo dpkg -i $FILE; rm $FILE
}


prompt_green "apt-get Installations"
sudo apt-get install -y \
  wget \
  git \
  curl \
  zsh \
  virtualbox-guest-dkms \
  virtualbox-guest-utils \
  virtualbox-guest-x11 \
  nethogs


prompt_green "Git configuration"
git config --global user.name $gituser
git config --global user.email $gitmail
git config --global push.default simple


prompt_green "Oh-My-Zsh installation"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh


# # get Java 8u45
# # TODO: use a better path
# tmpjavafile=/tmp/java8u45.tar.gz
# javaFolderName=jdk1.8.0_45
# shrcfile=.zshrc
# wget \
#   --output-document=$tmpjavafile \
#   --no-check-certificate \
#   --no-cookies \
#   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#   http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz
#
# tar xvzC ~/Programmes/ -f $tmpjavafile
# javapath=/home/$username/Programmes/$javaFolderName
# cat <<EOF >> $shrcfile
# # JAVA
# export JAVA_HOME=$javapath
# export PATH=$javapath/bin:\$PATH
# export secure_path=$javapath/bin:$secure_path
# EOF
# rm $tmpjavafile


prompt_green "atom.io installation"
download_and_install 'https://atom.io/download/deb'


prompt_green "docker installation"
wget -qO- https://get.docker.com/ | sh  # dl & install
sudo usermod -aG docker `whoami`        # adduser to docker group to remove sudo need
sudo systemctl enable docker

# sudo groupadd docker
# sudo gpasswd -a ${username} docker
