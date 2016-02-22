# Docker Helper
- [installation](#installation)
	- [linux](#linux)
	- [windows](#windows)
		- [informations](#informations)
		- [the boot2docker solution](#the-boot2docker-solution)
			- [powershell](#powershell)
			- [cygwin](#cygwin)
- [usefull links](#usefull-links)
- [usefull commands](#usefull-commands)


## installation
### linux
```bash
# need wget
sudo apt-get install wget

# download and install docker
wget -qO- https://get.docker.com/ | sh

# add user to docker group for removing sudo need
sudo adduser `whoami` docker

# on OS with systemd (Unbuntu 15.04 / ...), you can ask docker to be started automatically.
if [[ -n `which systemctl` ]]; then
  sudo systemctl enable docker
fi
```

### windows
#### informations
- Virtual Box doesn't seem to work on windows10 (May 2015)
- This tests are done on Windows 7
- Linux and windows does not use the same file system format. This result in difference with file ownership. It can make some problem running code.
- [this links](https://developer.ibm.com/bluemix/2015/04/16/installing-docker-windows-fixes-common-problems/) gives lots of common problems

#### the **boot2docker** solution
- Go to [boot2docker](http://boot2docker.io/) and download for windows. Version was 1.6.2 at the writing time.
- Run the installer.
- You should have a `Boot2Docker Start` shortcut on desktop, run it.
- It will create SSH keys, start the VM and give a prompt.
- Note this lines :
```bash
To connect the Docker client to the Docker daemon, please set:
  export DOCKER_HOST=tcp://..........
  export DOCKER_CERT_PATH=...........
  export DOCKER_TLS_VERIFIY=.........
```
- You will have to run these 3 lines before running a cmd.exe different than `boot2docker start`.
- Most of the commands are linux commands. Lots of them can be found in the git installation folder (May add gitFolder/bin to your PATH). For example, boot2docker use the git bash.
- Boot2docker start run a cmd.exe ... you can't copy/pate ... so maybe powershell (not explored) or cygwin is a better solution

##### powershell

    TODO

##### cygwin
Personnaly I use the cygwin solution for oh-my-zsh.

You first need to install boot2docker.  
Then [install cygwin](https://tdeheurles/docs/blob/master/cygwin).  
A `docker` command should return the help and a `docker ps` should fail. The first tells that docker client (boot2docker) is correctly installed, the second shows that the docker daemon (inside the VM) is not reachable from here (VM is not running or client cannot access for other reason).

To run the VM you can :
- clic on `boot2docker start`
- launch VirtualBox and start the VM.
- run `boot2docker` in terminal (need to add boot2docker to the PATH)

To tell where is the VM to cygwin, look what boot2docker Start as logged and add it to your bash environment :

```bash
# /!\ give bash or zsh
rcfile=~/.zshrc
# /!\ use the good IP /!\
vmAddress="192.168.59.103:2376"
cat <<EOF >> $rcfile

# docker
export DOCKER_CERT_PATH="/Users/$(whoami)/.boot2docker/certs/boot2docker-vm"
export DOCKER_TLS_VERIFIY=1
export DOCKER_HOST=tcp://$vmAddress
EOF
```

At the moment of the writing, I don't know how to fix that issue :
```
➜  ~  docker ps
time="2015-07-12T11:35:21+02:00" level=fatal msg="An error occurred trying to connect: Get https://192.168.59.103:2376/v1.18/containers/json: x509: certificate is valid for 127.0.0.1, 10.0.2.15, not 192.168.59.103"
```

so I simply workaround by desactivating tls control :
```bash
docker --tlsverify=false ps
```

You can add something like this to your rcfile :
```bash
rcfile=~/.zshrc
cat <<EOF >> $rcfile

# desactivate docker tls control
alias docker="docker --tlsverify=false"
EOF
```

#### the **kitematic** solution
You can install [kitematic](https://kitematic.com/). It's a UI that comes with a VM.   For now, the containers I tried to run have got trouble in this solution so I abandoned it.  
But the UI is pretty cool and it's an Alpha solution. Maybe it need just more time.

#### the inside VM solution
The idea is to simply use a linux VM and sync the folders you need.
- The [Vagrant-CoreOS](https://github.com/tdeheurles/coreos-vagrant) ssh solution
- The Vagrant-Ubuntu ui solution (to come)

## usefull links
- how to create its own [private repository](https://www.vultr.com/docs/setup-your-own-docker-registry-on-coreos)
- [releases](https://tdeheurles/docs/blob/master/RELEASES.md)

## usefull commands
Kill all running containers
```bash
docker kill $(docker ps -q)
```

Delete all stopped containers (including data-only containers)
```bash
docker rm $(docker ps -a -q)
```

Delete all ‘untagged/dangling’ (<none>) images
```bash
docker rmi $(docker images -q -f dangling=true)
```

Delete ALL images
```bash
docker rmi $(docker images -q)
```
