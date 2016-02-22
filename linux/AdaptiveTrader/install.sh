#! /bin/bash

scream() {
  echo "error on $1"
  exit 1
}

# PREREQUISITE
# ============

# add keys and update
# ===================
# mono keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" \
| sudo tee /etc/apt/sources.list.d/mono-xamarin.list

# eventstore
curl https://apt-oss.geteventstore.com/eventstore.key | sudo apt-key add -
echo "deb [arch=amd64] https://apt-oss.geteventstore.com/ubuntu/ trusty main" \
| sudo tee /etc/apt/sources.list.d/eventstore.list

# crossbar
sudo apt-key adv --keyserver hkps.pool.sks-keyservers.net --recv D58C6920
sudo sh -c "echo 'deb http://package.crossbar.io/ubuntu trusty main' \
    > /etc/apt/sources.list.d/crossbar.list"

sudo apt-get update
sudo apt-get upgrade -y


# install
# =======
# mono
sudo apt-get install mono-complete ca-certificates-mono -y

# dnvm
sudo apt-get install unzip curl -y
curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh \
| DNX_BRANCH=dev sh && source ~/.dnx/dnvm/dnvm.sh
dnvm upgrade -r mono

# Event Store
sudo apt-get install eventstore-oss -y

# crossbar.io
sudo apt-get install crossbar -y

# node
curl -L -O https://nodejs.org/dist/v5.1.0/node-v5.1.0-linux-x64.tar.gz
tar -zxvf node-v5.1.0-linux-x64.tar.gz
rm node-v5.1.0-linux-x64.tar.gz

# PATH
cat <<EOF >> ~/.bashrc
# node
export PATH=\$PATH:`pwd`/node-v5.1.0-linux-x64/bin
# crossbar
export PATH=\$PATH:/opt/crossbar/bin
# adaptive trader install folder
export ADAPTIVE_TRADER_FOLDER=`pwd`/adaptivetrader
EOF


# ADAPTIVE-TRADER
# ===============

# Clone repository
sudo apt-get install git -y
git clone https://github.com/adaptiveconsulting/adaptivetrader
pushd adaptivetrader/src
