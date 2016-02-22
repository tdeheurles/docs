#! /bin/bash

set -euo pipefail

if [[ $# != 1 ]];then
  echo "usage:"
  echo "  $0 DOMAIN_NAME"
  exit 1
fi
domainName=$1

openssl=$(which openssl)
if [[ $? == 1 ]];then
  echo "openssl is needed, exiting"
  echo " "
  exit 1
fi

certPath="/etc/ssl/$domainName"
mkdir -p $certPath
rm $certPath/* || true
cd $certPath

key="server.key"
csr="server.csr"
crt="server.crt"
pem="server.pem"

openssl genrsa -out $key 2048
openssl rsa -in $key -out $key
openssl req -sha256 -new -key $key -out $csr -subj "//CN=$domainName"
openssl x509 -req -days 365 -in $csr -signkey $key -out $crt
cat $crt $key > $pem
