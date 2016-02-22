# Encrypt password
[From here](https://github.com/GoogleCloudPlatform/kube-jenkins-imager)

To customize the basic access authentication credentials used to access the Jenkins UI, use htpasswd piped through base64 to create a new credential, then paste the output into the correct location in ssl_secrets.json:
> htpasswd -nb USERNAME PASSWORD | base64

(htpasswd is available in apache2-utils (sudo apt-get install apache2-utils))

Alternatively, you can base64-encode an existing .htpasswd file and add it to ssl_secrets.json
