# Run Ubuntu on windows
Short tutorial to run Ubuntu on VirtualBox

## with Virtualbox
- download ubuntu [desktop 15.10](http://www.ubuntu.com/download/desktop/thank-you?country=FR&version=15.10&architecture=amd64), [desktop 14.04.3](http://www.ubuntu.com/download/desktop/thank-you?country=FR&version=14.04.3&architecture=amd64), [server 15.10](http://www.ubuntu.com/download/server/thank-you?country=FR&version=15.10&architecture=amd64), [server 14.04.3](http://www.ubuntu.com/download/server/thank-you?country=FR&version=14.04.3&architecture=amd64)
- start new VM and install ubuntu
- when installed, run `curl https://raw.githubusercontent/tdeheurles/docs/ubuntu/bootstrapVirtualMachine | bash`
- run the `Software Updater` if proposed to
- good solution is to clone your VirtualMachine at this moment and use it as a base for all tests

## With Vagrant and Virtualbox (in progress)
### First you need to install :
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

### Create Vagrant project
Go to a folder where you will store your project

Then create Vagrantfile  
vagrant init ubuntu/vivid64; vagrant up --provider virtualbox

### preseed

### ip
ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'
