# Setup Lab Instructions

These are all the scripts for setting up the lab.  Mostly they
are Ansible playbooks to use against a metacloud lab environment. 

_All instructions assume you are using OSX as your workstation_

## 1. Get CoreOS image

Download the latest CoreOS image: 

### GUI approach
You can do this through the GUI if you have an extracted image somewhere.  Otherwise, you'll first have to download and extract the image and then use the GUI. 

![coreos](./images/glance.png)

### CLI approach
```
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_openstack_image.img.bz2
bunzip2 coreos_production_openstack_image.img.bz2
```
Create the image in OpenStack: 
```
glance image-create --name CoreOS \
  --container-format bare \
  --disk-format qcow2 \
  --file coreos_production_openstack_image.img \
  --is-public True
```

## 2. Allocate floating IP addresses

You will need 
* 1 IP address per 10 users
* 1 IP address for the CI/CD environment
* 1 IP address for the webserver that will run our code. 

__As an example: A class of 25 users would need 5 floating IP addresses.__


## Usage

The infra.yml requires some manual work while I wait for Ansible to 
fix their 2.0 stuff to work with metapod.  

* You have to create your own volume and mount it to the instance and
format it as well.  Doing an ```fdisk``` can make this happen.  

* Initial images need to be downloaded to the local registery (described below)

## Initial Registry Images. 

The infra.yml brings up a machine called ```ci```.  All the systems provisioned
in this lab are programmed to allow insecure docker communication to ```ci```. 

They expect several docker images to be there.  For each of the following
images you need to run: 

```
docker pull <image>
docker tag <image> ci:5000/<image>
docker push ci:5000/<image>
```

The images are: 

* jenkins
* nginx
* sameersbn/redis
* sameersbn/postgresql
* sameersbn/gitlab
