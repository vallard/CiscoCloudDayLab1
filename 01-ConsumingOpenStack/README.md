# Module 1: Consuming OpenStack APIs

This module will focus on using OpenStack APIs using various configuration
tools.  When completed, the user will gain an understanding of how to 
communicate with the OpenStack APIs in Metapod.  

Table of Contents
=================

  * [Module 1: Consuming OpenStack APIs](#module-1-consuming-openstack-apis)
  * [1\.1 Log into lab work stations](#11-log-into-lab-work-stations)
  * [1\.2 Exercise \- Build your Environment](#12-exercise---build-your-environment)
    * [1\.2\.1 Export Environment Variables](#121-export-environment-variables)
  * [1\.3 Exercise  \- Curl: Using raw APIs](#13-exercise----curl-using-raw-apis)
  * [1\.4 Exercise \- Using Python Clients](#14-exercise---using-python-clients)
    * [1\.4\.1 Show the python client libraries\.](#141-show-the-python-client-libraries)
    * [1\.4\.2 Launch a server](#142-launch-a-server)
    * [1\.4\.2\.1 List current servers](#1421-list-current-servers)
    * [1\.4\.3 Show OpenStack flavors](#143-show-openstack-flavors)
    * [1\.4\.4 Show OpenStack Images](#144-show-openstack-images)
    * [1\.4\.5 Generate a Keypair](#145-generate-a-keypair)
    * [1\.4\.6 Create a new instance](#146-create-a-new-instance)
    * [1\.4\.7 Log In to the new Instance](#147-log-in-to-the-new-instance)


## 1.1 Log into lab work stations

The instructor will have several IP addresses available for you to log
into.

You will also get a user ID assigned to you. 

You will need to ssh into the lab client on port 2222.  

On a MAC: 
```
ssh -p 2222 userXX@<IP ADDRESS> 
```

The password is ```Cisco.123```

_Note:  You may wish to do some of these exercises on your own laptop.  Setting
up your laptop for development is a very personal decision and not one we will 
cover in these labs. You are welcome and encouraged to try and adapt these instructions 
to your own environment._  

## 1.2 Exercise - Build your Environment

Login to the Metapod horizon dashboard.  This is a URL that should be posted
at the front of the class.  

Click on the __ACCESS AND SECURITY__ 

![Dashboard](images/d1.png "Metapod Dashboard")

Navigate to the __API Access__ tab in the workpane and download the Openstack RC file. 

![API Access ](images/d1.png "API Access")

This file contains all the environment variables we need to access the APIs.  Save this 
file then open with a text editor to see what was set. 

### 1.2.1 Export Environment Variables

Edit the ```~/.profile`` file.  This file contains settings that get executed each time
a user logs into the shell. 

You can use vi or nano. If you want emacs installed then you should probably just stop
using this lab right now.  

[There's a nice 5 minute introduction](http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Editors/ViIntro.html)
to vi that might help if you wish to learn that.  (recommended if you are not!)

```
export OS_AUTH_URL=""
export OS_TENANT_ID=""
export OS_TENANT_NAME=""
export OS_USERNAME=""
export OS_PASSWORD=""
export OS_REGION_NAME="RegionOne"
```
Setting these environment variables will allow your other programs to access the 
APIs of the lab for all the excercises.  

Log out and log back in for your environment variables to become active.  
Alternatively, run the command: 

```
. ~/.profile
```

When you log in make sure you see all the environment variables defined: 

```
env | grep OS
```

_NOTE: The OpenStack RC file that you download asks you to enter your password when
you first login to a new shell.  This doesn't work so well in the .profile file. 
So this is really just a matter of style.  You can also chose to simply source the 
OpenStack file you downloaded from Metapod._

## 1.3 Exercise  - Curl: Using raw APIs

The OpenStack APIs return JSON responses to common web requests.  We can use curl to simply
make web calls to the interface.  Let's try running a curl request against the OpenStack
Authentication URL: 

```
curl $OS_AUTH_URL
```

You should receive a bunch of text back in one line similar to the below:

```json
{"version": {"status": "stable", "updated": "2014-04-17T00:00:00Z", "media-types": [{"base": "application/json", "type": "application/vnd.openstack.identity-v2.0+json"}, {"base": "application/xml", "type": "application/vnd.openstack.identity-v2.0+xml"}], "id": "v2.0", "links": [{"href": "http://api-demo1.client.metacloud.net:5000/v2.0/", "rel": "self"}, {"href": "http://docs.openstack.org/api/openstack-identity-service/2.0/content/", "type": "text/html", "rel": "describedby"}, {"href": "http://docs.openstack.org/api/openstack-identity-service/2.0/identity-dev-guide-2.0.pdf", "type": "application/pdf", "rel": "describedby"}]}}
```

This return format is called JSON.  
JSON = Javascript Object Notation.  JSON is great because its compact and easy to learn

[Learn more about JSON in this five minute official introduction.](http://www.json.org/)

_Note:  If you get something that looks like an error please check that your environment 
variables are set up correctly by going through section 1.2._

## 1.4 Exercise - Using Python Clients

OpenStack has python client libraries that can be installed to make managing your cloud via
the command line a convenient way to execute common tasks.  

### 1.4.1 Show the python client libraries.

Run the command below:
```
pip list
```

This gives you a list of python packages (libraries) that are installed on the system.  

Pip is a python packaging tool that allows for simple downloading of python libraries.  You'll see
that several OpenStack python clients have been installed.  The client names correspond to the 
project.  

```
python-cinderclient (1.4.0)
python-heatclient (0.7.0)
python-keystoneclient (1.7.1)
python-novaclient (2.29.0)
python-swiftclient (2.6.0)
```    

If you had ```sudo``` access you would be able to install other python libraries by running the 
```pip install``` command. 

### 1.4.2 Launch a server

Now that you see several OpenStack python client libraries are installed we can use these libraries
to launch an instance.  

In cloud computing we typically call 'vms' 'instances' to denote their ephemeral nature. 

#### 1.4.2.1 List current servers
Let's start by listing the existing servers that are currently running in your project. 
This can be done by running the below command:

```
nova list
```

These are the currently running servers.  Nova is the OpenStack Compute project so actions that
require operations on instances are usually performed using nova.  

Take note of the names.  When we create a new server, we don't want to duplicate a name that is
already there!  OpenStack allows this, but this creates confusion!

#### 1.4.3 Show OpenStack flavors

A flavor is an abstraction that describes the virtual hardware of what an instance looks like. 
For example, a flavor details: 

* The number of vCPUs
* The amount of RAM
* Available disk

Run the command: 

```
nova flavor-list
```

This will show the different flavors availabe in the system.  In Metapod the administrators have
the ability to create different flavors.  For example, a project may require a flavor that uses
all the resources of a physical machine for using Apache Spark with HDFS.  

Take note of the m1.large ID.  This may be 3 or something else.  We can get more information on this

```
nova flavor-show 3
```

alternatively you can run: 
```
nova flavor-show m1.large
```

and get the same results. 

OpenStack tries to stick with the CRUD model, so for most subcommands there is a ```-show```, ```-delete```
, and ```-list``` command. 

#### 1.4.4 Show OpenStack Images

```
nova image-list
```
or 
```
glance image-list
```

You should see lots of images!  Cisco Metapod comes with many already predefined for you.  Most 
environments will make their own.  

Find the ubuntu image ```ubuntu-14.04-server``` as this is what we'll use.  

#### 1.4.5 Generate a Keypair

In order to log into an instance that we will create we need to make a keypair.  The Keypair 
consists of a public and private key.  The public key will be installed on the instance when 
it is launched and the private key we will download and use to log into the instance.  

Run the command: 
```
nova keypair-add <name>key | tee <name>key.pem
chomd 600 <name>key.pem
```
Where <name> is your name, or some amazingly distinguished unique name that you will know is
yours.  

This command will generate the output of the private key. The ```tee`` command is a shell
command that will pipe the key output to a file called ```<name>key.pem```

Running the command 

```
nova keypair-list
```

will show you all the keys in your system.  You can delete the key you made later by running
```
nova keypair-delete <name>key
```

#### 1.4.6 Create a new instance

Run the following command to create a new instance

```
nova boot --flavor m1.large --image ubuntu-14.04-server --key-name <name>key <name>firstimage
```

Where ```<name>``` is your fun unique name.  

Check on the status to see if the server has been created using the ```nova list``` and 
```nova show <name>firstimage``` commands.

#### 1.4.7 Log In to the new Instance

To make sure you did it right, log into the new instance you just created:
```
ssh -i <name>key.pem ubuntu@<name>firstimage
```
where ```<name>``` is once again the unique name you picked. 

If all is successful you should be able to login with out a password: 
```
$ ssh -i chomp.pem ubuntu@chomp
Welcome to Ubuntu 14.04.3 LTS (GNU/Linux 3.13.0-62-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

   System information as of Tue Sep 15 19:41:25 UTC 2015

   System load: 0.0               Memory usage: 1%   Processes:       76
   Usage of /:  56.9% of 1.32GB   Swap usage:   0%   Users logged in: 0

   Graph this data and manage this system at:
       https://landscape.canonical.com/

   Get cloud support with Ubuntu Advantage Cloud Guest:
       http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

ubuntu@chomp:~$ 
```

This concludes Exercise 1.4.  You have created an instance using the 
command line. Everything you have done so far could also be done on 
the Horizon dashboard that Metapod provides.  


