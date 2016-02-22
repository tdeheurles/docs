#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl
curl -o /tmp/install.sh https://raw.githubusercontent.com/tdeheurles/docs/master/VM/debian-docker-jenkins-nginx.sh
cd /tmp
sudo chmod 755 /tmp/install.sh 
sudo ./install.sh
