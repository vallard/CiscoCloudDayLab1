# Module 1: Consuming OpenStack APIs

This module will focus on using OpenStack APIs using various configuration
tools.  When completed, the user will gain an understanding of how to 
communicate with the OpenStack APIs in Metapod.  

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

Open 


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


## 1.3 Exercise  - Curl: Using raw APIs

The OpenStack APIs return JSON responses to common web requests.  We can use curl to simply
make web calls to the interface.  Let's try running a curl request. 

```
curl
```

Note:  If you get an error please check that your environment variables are set up correctly.

## 1.4 Exercise - Using Python Clients

OpenStack has python client libraries that can be installed to make managing your cloud via
the command line a convenient way to execute common tasks.  

### 1.4.1 Show the python client libraries.

```
pip list
```

Pip is a python packaging tool that allows for simple downloading of python libraries.  You'll see
that several OpenStack python clients have been installed.  The client names correspond to the 
project.  

You can install other python libraries by running the ```pip install``` command.  Let's install
a client that we're missing:

```
pip install troveclient
```

### 1.4.2 Launch a server

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
python
Ansible
Heat (Use Steve Watkins Heat Template)
Terraform

