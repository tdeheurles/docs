if [[ $# != 1 ]]; then
   echo "args usage : "
   echo "  1- password "
   echo " "
   exit 1
fi

# hash password
password=`echo $1 | mkpasswd --method=SHA-512 --rounds=4096 -s`

# add needed package
sudo apt-get install -y curl wget whois

# get discovery url
discoveryUrl=`curl https://discovery.etcd.io/new`

# write cloud-config.yml
cat <<EOF2 > cloud-config.yml
#cloud-config

users:
  - name: core
    passwd: $password
    groups:
      - sudo
      - docker

coreos:
  etcd:
    name: node01
    discovery: $discoveryUrl

hostname: node01
EOF2

# get the coreos installation script
wget https://raw.github.com/coreos/init/master/bin/coreos-install

# run installation
chmod 755 coreos-install
sudo ./coreos-install \
      -d /dev/sda \
      -c cloud-config.yml \
      -C alpha
