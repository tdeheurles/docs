#! /bin/bash
if [[ $# != 2 ]]; then
  echo "Usage, give :"
  echo " 1- username"
  echo " 2- password"
  echo " "
  exit 1
fi

sudo adduser --disabled-password --gecos "" $username
echo -e "$password\n$password\n" | sudo passwd $username
sudo adduser $username sudo
# ssh-keygen -b 1024 -f $username -t dsa
# sudo mkdir -p /home/$username/.ssh
# cat $username.pub | sudo tee -a /home/$username/.ssh/authorized_keys
# sudo chmod 600 /home/$username/.ssh/authorized_keys
# sudo chmod 700 /home/$username/.ssh
sudo chown -R $username /home/$username
