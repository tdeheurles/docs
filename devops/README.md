# DevOps

## OS
Os can be automated. There is 4 principal category for automation :
Build (Automation) :
- Build machine templates (Packer)
- Provision infrastructure (Terraform, CloudFormation)
- Configure infrastructure (Puppet, Chef, and the new one : Ansible, Salt)
- running (vagrant)

### Packer
Packer is a tool that take in one hand the `iso` of an OS and in the other `templates`. From that it will produce an `image`. This image can be for VirtualBox, VMWare, Amazon EC2, Google Compute Engine, etc. It then can provision this image with program/service installations. Finally, it can apply a post-processor for Vagrant, Atlas, etc.

#### Links
- [Quick go in](http://blog.aarhusworks.com/slipstreaming-vm-imags-with-packer/)
- [Quick tuto](http://blog.endpoint.com/2014/03/provisioning-development-environment.html)

#### Templates
There is different type of template files :
- packer.json
-

https://help.ubuntu.com/community/Cobbler/Preseed
https://wiki.debian.org/fr/DebianInstaller/Preseed

### Vagrant
#### Links
- [Tutorial - lvl_0](http://jeqo.github.io/blog/devops/vagrant-quickstart/)

#### Tricks
- provisioning : you provision as root user by default, add `privileged: false` to be the vagrant user
- Add `vagrant-winnfsd` dependencie to Vagrant for Windows to be able to use NFS
-
