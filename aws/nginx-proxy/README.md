## AWS-Nginx-Proxy

#### IAM account

First, your admin need to generate an IAM account, add you to a group with enough priviledge.  
Then you can go to the login page of your admin (ask him for the <adminId>):

    https://<adminId>.signin.aws.amazon.com/console/

Connect to that page and give your user/password. You will then be connected to AWS dashboard.

#### EC2

EC2 is the AWS VM solution. 

- **Go to EC2.**
![aws-dashboard](readme1.jpg)

- **Select your zone**
![aws-dashboard](readme3.jpg)

- **Create new instance**
![aws-dashboard](readme2.jpg)

- **Select your OS**
![aws-dashboard](readme4.jpg)

- **Select your machine performances**
![aws-dashboard](readme5.jpg)

- **Select your machine performances**
![aws-dashboard](readme6.jpg)

  - A: select/create VPC
  - B: select/create subnet
  - C: enable auto-assign Public IP
  - D: Click `Review and Launch`

- **select/create key-pair**
![aws-dashboard](readme7.jpg)

  - A: select/create key/pair
  - B: select or give a name
  - C: download it
  - D: Start the instance

- **Go to your instance**
![aws-dashboard](readme8.jpg)

  - A: monitor creation
  - B: go to the instance

- **Get your Public-IP and connect with ssh**
![aws-dashboard](readme9.jpg)

  - A: get Public IP
  - B: connect via ssh by following the instructions
  
#### Setup nginx

run that command:

```bash
file="/tmp/install.sh"
curl https://raw.githubusercontent.com/tdeheurles/docs/master/aws/nginx-proxy/install-nginx.sh \
  > $file         && \
  chmod 755 $file && \
  bash $file
```

#### Control installation

From inside the VM (ssh):

```bash
curl localhost
```
You should have a `Hello` response

From outside the VM:

#### Open Firewall

- **Go to AWS dashboard and open VPC**
![aws-dashboard](readme10.jpg)

- **Go to security group**
![aws-dashboard](readme11.jpg)

- **Go to security group**
![aws-dashboard](readme11.jpg)


```bash
publicIp="???.???.???.???"
curl $publicIp
```
