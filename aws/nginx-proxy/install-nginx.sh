#! /bin/bash

# fail fast
set -euo pipefail

# control parameters
if [[ $keepalive_timeout1 == "" ]];   then echo "keepalive_timeout1 ENV needed";    exit 1 fi
if [[ $keepalive_timeout2 == "" ]];   then echo "keepalive_timeout2 ENV needed";    exit 1 fi
if [[ $send_timeout == "" ]];         then echo "send_timeout ENV needed";          exit 1 fi
if [[ $proxy_connect_timeout == "" ]];then echo "proxy_connect_timeout ENV needed"; exit 1 fi
if [[ $proxy_send_timeout == "" ]];   then echo "proxy_send_timeout ENV needed";    exit 1 fi
if [[ $proxy_read_timeout == "" ]];   then echo "proxy_read_timeout ENV needed";    exit 1 fi
if [[ $server_name == ""]];           then echo "server_name ENV needed";           exit 1 fi
if [[ $address_to_proxy == ""]];      then echo "address_to_proxy ENV needed";      exit 1 fi

# install docker
sudo apt-get update
sudo apt-get install -y nginx

# add it as a service
cat<<EOF > /tmp/nginx.conf
description "nginx daemon"

start on runlevel [2345]
respawn
EOF
sudo cp /tmp/nginx.conf /etc/init/nginx.conf

# give an update script
cat<<EOF > ~/updateNginx.sh
#! /bin/bash

sudo vi /etc/nginx/nginx.conf

# restart
sudo initctl stop nginx
sudo initctl start nginx
EOF
chmod 755 ~/updateNginx.sh

# update configuration
cat<<EOF > /tmp/nginx.conf
# http://yojimbo87.github.io/2012/10/23/signalr-behind-nginx.html
worker_processes 4;
pid /run/nginx.pid;

events {
        worker_connections 768;
}

http {
  access_log /var/log/nginx/access.log;
  error_log  /var/log/nginx/error.log;

  keepalive_timeout $keepalive_timeout1 $keepalive_timeout2;
  send_timeout      $send_timeout;

  proxy_connect_timeout $proxy_connect_timeout;
  proxy_send_timeout    $proxy_send_timeout;
  proxy_read_timeout    $proxy_read_timeout;

  proxy_buffering off;

  server {
    listen      80;
    server_name $server_name;
    
    location {
        proxy_pass http://$address_to_proxy/;
        
        proxy_set_header Host            \$host;
        proxy_set_header X-Real-IP       \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
  }
}
EOF
sudo cp /tmp/nginx.conf /etc/nginx/nginx.conf

# change owner
sudo chown ubuntu /var/log/nginx/access.log
sudo chown ubuntu /var/log/nginx/error.log

# create a index.html to control installation
sudo mkdir -p /www
echo "Hello" > /tmp/index.html
sudo cp /tmp/index.html /www/index.html

# start service
sudo initctl start nginx
