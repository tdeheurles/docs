# SSL how to
[From here](http://www.linux-france.org/prj/edu/archinet/systeme/ch24s03.html)

## Create server certificate
Generate the private key
> openssl genrsa 1024 > jenkins.key

Generate request for signature :

*/!\ Common name is our server host name*
> openssl req -new -key jenkins.key > jenkins.csr

## Now we need a certificat from authority
Two ways :
- use a private company (pay for it)
- do it ourself

We'll do it ourself :

We generate a new private key
> openssl genrsa -des3 1024 > ca.key

And use it for creating a x509 certificat
> openssl req -new -x509 -days 365 -key ca.key > ca.crt


## We then sign our server certificat request
> openssl x509 -req -in jenkins.csr -out jenkins.crt -CA ca.crt -CAkey ca.key -CAcreateserial -CAserial ca.srl

## Generated files :
- ca.crt : certificate
- ca.key : private key
- ca.srl : signed certificate
- servwiki.crt : certificate
- servwiki.key : private key
- servwiki.csr : certificate signing request
