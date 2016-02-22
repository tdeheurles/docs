# kubernetes
- [kubernetes](#kubernetes)
	- [Intro to kubernetes](#intro-to-kubernetes)
		- [On Your Machine](#on-your-machine)
			- [Installation](#installation)
				- [Explanation](#explanation)
				- [How to](#how-to)
				- [Go further in installation](#go-further-in-installation)
			- [UI](#ui)
			- [Simple example](#simple-example)
		- [On Google Cloud Container](#on-google-cloud-container)
		- [On CoreOS VM with one node on each computer](#on-coreos-vm-with-one-node-on-each-computer)
	- [Objects](#objects)
	- [v1 Objects](#v1-objects)

## Intro to kubernetes
### On Your Machine
#### Installation
##### Explanation
One of the easiest way I have found is to go through the
[pires project](https://github.com/pires/kubernetes-vagrant-coreos-cluster). It support Windows/Linux/MAC with different provider VirtualBox/VMWare/Parallel. It run as a cluster. I just had to fork for making project to use local docker with no addition of local docker registry. The fork is [here](https://github.com/tdeheurles/kubernetes-vagrant-coreos-cluster).

An other way can be found [here](https://github.com/meteorhacks/kube-init), kubernetes is run locally on Ubuntu (no cluster here).

##### How to
First you need to install :
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

Look at the file named `synced_folders.sample.yaml`, copy it to synced_folders.yaml and add the folder you want. For multiple folders, add yaml list with some `-`
```yaml
- name: repository
  source: c:/Users/username/repository
  destination: /repository
  nfs: true
  mount_options: 'nolock,vers=3,udp,noatime'
  disabled: false
- name: ...
```

Then it's very complicated to start :
```bash
git clone https://github.com/tdeheurles/kubernetes-vagrant-coreos-cluster
vagrant up
```
Connect with the following :
```bash
vagrant ssh
```

Try to ssh in and run `kubectl` command, if the help appear, it's fine.

##### Go further in installation
Go [here](https://coreos.com/docs/cluster-management/setup/cloudinit-cloud-config/) if you want to make some configuration to your CoreOS.

For now, i think it's easier to not fork that project. I just add my coreos .bashrc inside. For that, go to the `master.yaml` and add this to the `write-files` section :
```yaml
write-files:
  - path: /home/core/.bashrc
    permissions: '644'
    content: |
      # put your bashrc stuff here
```

You can also go in the start of the vagrant file where some configuration are available (cpu/memory allocated, etc). The number of node should stay at 0. If you add nodes, the cluster will run (it the idea of pires project), but docker won't be synced with each nodes. For now, just run 1 node for local projects/test.

#### UI
First, know that a UI is accessible to see how your cluster is running. It provide some information for the ones that don't like CLI.

ssh in the matser
```bash
vagrant ssh master
```

ask kubectl for informations
```bash
kubectl cluster-info
Kubernetes master is running at http://172.17.8.101:8080
kube-dns is running at http://172.17.8.101:8080/api/v1/proxy/namespaces/default/services/kube-dns
```

Open a browser and go to the master address adding `/ui` path at the end.

#### Simple example
You can follow the [local-kubernetes-nginx](https://github.com/tdeheurles/docs/tree/master/nginx#local-kubernetes-nginx-ws) tutorial.

### On Google Cloud Container
TODO

### On CoreOS VM with one node on each computer
TODO

## The different services
### Pre-requisites
##### Docker
##### etcd
etcd is a consistent cluster key-value storage.
##### flanneld
### Master services
##### apiserver
The apiserver is the entrance to kubernetes. It will control manifest and push them to controller-manager.
##### controller-manager
Here run the main loop of kubernetes. It will manage replication/namespace/endpoints/account controllers.
=> [Official documentation](https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/kube-controller-manager.md)
##### kube-scheduler
This services choose the node where each pod will run.
=> [Official documentation](https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/kube-scheduler.md)
=> [Talk about proxy in service documentation](https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/services.md#virtual-ips-and-service-proxies)
### Node services
#### kube-proxy
The porxy is the one acting for making available k8s-services (the service defined by manifest).
[Official documentation](https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/kube-proxy.md)
#### kubelet
The kubelet work for applying the contract from manifest on the node it runs. These contracts are given by the api-server. It looks for the "healthy part" of the pod.
=> [Official documentation](https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/kubelet.md)

## Objects
The api can be looked [here](http://kubernetes.io/third_party/swagger-ui/)

## v1 Objects
```
Binding                         ?

ComponentStatuses               ?

Endpoints                       ?

Events                          ?

LimitRanges                     ?

Namespaces                      To isolate groups of service,rc,pods ...

PersistentVolumeClaims          ?

Pods                            K8S smallest action unit. One or more container
                                   as one unit

Podtemplates                    ?

RC - Replicationcontrollers     RC manage pods lifetime. You set how many pods
                                   of a kind you want, and it will create or
                                   delete pods automatically.

Resourcequotas                  ?

Secrets                         Item used to give secret configuration to pods.
                                   secrets are seen as volume inside pods.

Serviceaccounts                 ?

Services                        This item is the public interface of pods.
                                   It can be used as a LoadBalancer.

Nodes                           Nodes are the unit of the cluster

Persistentvolume               ?

```
