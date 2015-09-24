# Setup

These are all the scripts for setting up the lab.  Mostly they
are Ansible playbooks to use against a metacloud lab environment. 

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
