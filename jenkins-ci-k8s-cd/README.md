# Create CI/CD using jenkins and kubernetes

## notes
Under construction

## Introduction
This tutorial present my process for creating projects into kubernetes.

I use the [jenkins-gcp-imager](https://github.com/GoogleCloudPlatform/kube-jenkins-imager) as a CI server so you can work from anywhere and have your code near your cluster.

The CD is integrated in kubernetes.

## project construction
First we will init our project from a [template](https://github.com/tdeheurles/k8s-base).

```bash
projectname=foo
git clone --depth=1 git://github.com/tdeheurles/k8s-base $projectname
rm -rf !$/.git
```
will create something like that :
```bash
.
├── build
│   ├── main.sh
│   └── template.Dockerfile
├── config
│   └── release.cfg
├── deploy
│   └── kubernetes
│       ├── createManifests.sh
│       ├── getManifests.sh
│       └── v1
│           ├── rc.template.yml
│           ├── secret_ssl.template.yml
│           ├── secret_ssl.yml
│           └── service.template.yml
└── src
    └── README.md
```

First go in release.cfg and change projectid to match your google cloud project :
```bash
# Service name, will be used for service DNS
servicename=""

# Manual versioning part
servicemajor=0
serviceminor=0

# Project registry to stock the container
projectid=""

# ports
serviceportname="http"
serviceport=80

# api
k8s_api_version="v1"
template_extension="yml"
```

Then go to deploy/kubernetes.

the `createManifests.sh` will be used by `main.sh` for preparing manifests at build time (can be done at deploy time if you add the build_number as an argument).
```bash
#! /bin/bash
. ./config/release.cfg
BUILD_NUMBER=$2

versiontag=$servicemajor.$serviceminor.$BUILD_NUMBER
manifestsPath="./deploy/kubernetes"

# RC
rcfile=$manifestsPath/$servicename\_$versiontag\_rc.$template_extension
rcname=$servicename

sed "s/__rcName__/$rcname/g" \
    $manifestsPath/$k8s_api_version/rc.template.$template_extension > $rcfile
sed -i "s/__major__/$servicemajor/g" $rcfile
sed -i "s/__minor__/$serviceminor/g" $rcfile
sed -i "s/__build__/$BUILD_NUMBER/g" $rcfile
sed -i "s|__image__|$1|g" $rcfile
sed -i "s/__privatePortName__/$serviceportname/g" $rcfile
sed -i "s/__privatePort__/$serviceport/g" $rcfile
sed -i "s/__replicas__/1/g" $rcfile


# SERVICE
servicefile=$manifestsPath/$servicename\_$versiontag\_service.$template_extension
sed "s/__serviceName__/$servicename/g" \
    $manifestsPath/$k8s_api_version/service.template.$template_extension > $servicefile
sed -i "s/__major__/$servicemajor/g" $servicefile
sed -i "s/__minor__/$serviceminor/g" $servicefile
sed -i "s/__build__/$BUILD_NUMBER/g" $servicefile
sed -i "s/__privatePortName__/$serviceportname/g" $servicefile
sed -i "s/__publicPortName__/$serviceportname/g" $servicefile
sed -i "s/__publicPort__/$serviceport/g" $servicefile
sed -i "s/__rcName__/$rcname/g" $servicefile

cp $rcfile $manifestsPath/rc_latest.$template_extension
cp $servicefile $manifestsPath/service_latest.$template_extension

echo "Manifests generated"
```

This file import some conf informations and generate service and RC manifests from the templates.
