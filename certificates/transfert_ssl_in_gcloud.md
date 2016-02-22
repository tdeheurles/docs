# Transfert our SSL certificate in gcloud
[From here](https://github.com/GoogleCloudPlatform/kube-jenkins-imager)

For SSL creation, look at *create_ssl_certificates.md*

First encode our crt
> base64 -i servwiki.crt

> base64 -i servwiki.key

Update your ssl_secrets.json with the output
>"data": {
  ...
  "proxycert": "YOUR_BASE64_ENCIDED_CERT",
  "proxykey": "YOUR_BASE64_ENCIDED_CERT"",
  ...
}

Generate a DHE Parameter to ensure a secure SSL setup;
> openssl dhparam -out somessl.pem 2048

base64 encode it:
> base64 -i somessl.pem

>  {
  "apiVersion": "v1beta3",
  "kind": "Secret",
  "metadata": {
    "name": "ssl-proxy-secret",
    "namespace": "default"
  },
  "data": {
    "htpasswd": "amVua2luczokYXByMS............",
    "proxycert": "LS0tLS1CRUdJTiBDRVJU.........",
    "proxykey": "LS0tLS1CRUdJTiBDRVJU..........",
    "dhparam": "LS0tLS1CRUdJTiBESCBQQVJBTUVU..."
  }
}

Finally, modify ssl_proxy.json and change the ENABLE_SSL value to true:

>...
{
  "name": "ENABLE_SSL",
  "value": "true"
},
...
