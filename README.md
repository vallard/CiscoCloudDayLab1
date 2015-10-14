# Cisco Cloud Days Lab
This repository contains instructions for people to learn to use
Cisco MetaPod in a development environment. These are contained in the
three modules listed below. 

This repository also contains ansible scripts to deploy the lab
workstations and infrastructure required to any Metapod environment. 

Contact [@vallard](http://twitter.com/vallard) for any information or
other details. 

## Day at a Glance
There is 4 hours of training material so plenty of times for breaks, lunch,
and ratholing down topics of interest.

### [Module 1: Consuming OpenStack APIs](https://github.com/vallard/CiscoCloudDayLab1/tree/master/01-ConsumingOpenStack)

The first module goes over setting up the lab machine environment and then
using various ways to communicate with the Cisco Metapod APIs including

* curl
* python clients
* native python
* ansible
* Terraform

### [Module 2: Revision Control and Artifact Repositories](https://github.com/vallard/CiscoCloudDayLab1/tree/master/02-GitAndRegistries)

This module introduces git and talks about branches, pull requests, etc. 
It also talks about Docker Registries. 

### [Module 3: Continuous Integration](https://github.com/vallard/CiscoCloudDayLab1/tree/master/03-ContinuousIntegration)

This module talks about creating the application delivery pipeline. 
Users get hands on experience with using Jenkins with the tools discussed 
in the previous modules. 


## Items required by instructor

* See [Setup Instructions](https://github.com/vallard/CiscoCloudDayLab1/tree/master/00-Setup#cisco-cloud-days-lab)

* Ensure there is an ubuntu image available for the students to boot.  This version of the lab uses an image called ```ubuntu-14.04-server```.  This should be changed when the lab first starts depending on the environment.  This is in [section 1.4.6](https://github.com/vallard/CiscoCloudDayLab1/tree/master/01-ConsumingOpenStack#146-create-a-new-instance)

* Create a jenkins account for gitlab.  This can use the same key as the jenkins master to jenkins slave.  
  * The key for the jenkins gitlab account should be the one that is used 

* Configure Jenkins as specified in this [blog post]( http://benincosa.com/?p=3352 ). 

* Ensure the Docker agent is running on the Docker image vallard/metaclient for users.  
