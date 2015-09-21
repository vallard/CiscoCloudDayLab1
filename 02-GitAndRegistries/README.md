# Module 2: Revision Control (Git) and Containers (Docker)

* [2\.1 Git](#21-git)
  * [2\.1\.1 Sign up for Github](#211-sign-up-for-github)
  * [2\.1\.2 Create your own project](#212-create-your-own-project)
  * [2\.1\.3 Working with Git](#213-working-with-git)
  * [2\.1\.4 Branches with Git](#214-branches-with-git)
  * [2\.1\.5 Open an Issue](#215-open-an-issue)
  * [2\.1\.6 Clone a repository](#216-clone-a-repository)
  * [2\.1\.7 Pull Requests](#217-pull-requests)
* [2\.2 Docker](#22-docker)
  * [2\.2\.1 Searching Containers](#221-searching-containers)
  * [2\.2\.2 Downloading Docker Images](#222-downloading-docker-images)
  * [2\.2\.3 Starting Docker Images](#223-starting-docker-images)
  * [2\.2\.4 Volumes, Environment Variables](#224-volumes-environment-variables)
  * [2\.2\.5 Building a basic Container](#225-building-a-basic-container)
* [2\.3 (Optional) Setting Git and Docker on your own laptop](#23-optional-setting-git-and-docker-on-your-own-laptop)


In the last lab you learned about using APIs with Metapod. 

This module will introduce git and talk about branches, pull requests, etc. 
We will also talk about Docker Registries: Places to store your docker images

## 2.1 Git

_Git is a free and open source distributed version control system designed
to handle everything from small to very large projects with speed and
efficiency._

Version control systems have been around for years and there is more than just
git.  Git, however has some properties that make it very popular.  Primarily
its the ability to merge and branch changes that make it so effective.  While
you may think its something only used by developers, as we start to think of
"Infrastructure as Code" it makes sense that we maintain iterations of our
infrastructure in a convenient place.  Git provides this for us.  

What else can be stored in git?  All kinds of things!  Presentations, websites, 
resumes, etc. 

### 2.1.1 Sign up for Github

While git is free and opensource, Github is a company that stores github repositories
for you.  You can make as many repositories as you want in Github for free but 
they are publicly available.  So never store sensative things like passwords or 
account information on it.  

If you do not have an account, [sign up for Github now](http://github.com). There
is no cost to sign up for free.  

When selecting your email, you may want to use a personal email instead of a Cisco
email.  When selecting passwords, keep this in mind. 

![Password Hints](http://imgs.xkcd.com/comics/password_strength.png)

![Github signup](./images/gh1.png)

### 2.1.2 Create your own project

Once logged into Github, click the '+ New repository' button on the right hand side. 

![Github project create](./images/gh2.png)

* Repository Name: cloudtest
* Description: Some awesome description
* Public: Github repositories are public by default.  Private repos cost money. 
* Initialize with a README is checked
* Add a license: Select the apache 2 license.  

Licenses are plentiful in software.  You're even allowed to make your own but the 
Apache2 is widely recognized and if someone wants to use your code they may ask
you to put this license in.  

Once you are complete, select __Create Repository__ and you'll be directed to the
repo.  

![Github initial Project](./images/gh3.png)

### 2.1.3 Working with Git

Now that we have the repository we are going to start working with it.  Let's first
download the repo, or 'clone' it. 

Inside the lab machine run the command: 

```
git clone <your repo>
```
Where ```<your repo>``` is the clone URL shown on the right side of the web page.  You can 
click on the clipboard to do this.  

As an example, if you wanted to get Vallard's cloudtest repo you would run:

```
git clone https://github.com/vallard/cloudtest.git
```
this will create a directory called cloudtest.  

Typically people will have a directory where all code lives.  For example if you have a 
Mac you might have a directory called ```~/Code``` and change to that directory before 
you ever run ```git clone``` commands.  

#### Make changes ####
```
cd cloudtest
```
Here we can edit the README.md file.  The 'md' in this case stands for markdown.  
Markdown is a formatting language that is supposed to be more simple than 
markup languages like HTML.  The syntax for Markdown files can be found
[here](http://daringfireball.net/projects/markdown/syntax).  This lab in fact
was written in markdown.  

Let's edit the ```README.md``` file by opening it with ```vim``` or ```pico```.  

Upon opening it, we can see that it looks as follows: 

```
# cloudtest
This is a test project
```

Make some edits so that the file is different, either by adding a line, or
changing the description line.  Then save and close the file.  

Once saved run: 
```
git status
```
You'll see that git is tracking that this file has been changed but the 
changes have not been committed.  Now commit the changes: 
```
git commit -am "made a change"
```
The 'made a change' preceeded by the ```-m``` flag gives the message of the commit
so others can see what the general idea of your change was.  
The ```-a``` flag signifies to commit all changed files. 

So far all the changes have been made locally, but if we look at 
github, nothing has changed upstream.  We will need to commit these changes to
the master.  This is done by running: 
```
git push
```
You will be prompted for your Github user account and password.  Once you enter this
changes will be pushed upstream. If two or more developers were working on the same
code then the other developer would need to run ```git pull``` while in his local
repo to sync to the latest changes. 


### 2.1.4 Branches with Git

### 2.1.5 Open an Issue

### 2.1.6 Clone a repository

### 2.1.7 Pull Requests 

## 2.2 Docker

Docker containers are one of the hottest trends to hit application developers and 
IT administrators in the last several months.  Docker really became usable in 
mid 2014 but is still relatively young.  In this section we are going to run several
exercises to get familiar with containers.  

### 2.2.1 Searching Containers

On the lab workstation run the commands: 
```
sudo docker search python
```
This will show several docker containers you can download and use.   

### 2.2.2 Downloading Docker Images

### 2.2.3 Starting Docker Images

### 2.2.4 Volumes, Environment Variables

### 2.2.5 Building a basic Container

## 2.3 (Optional) Setting Git and Docker on your own laptop

[Download and install the Docker Toolbox](https://www.docker.com/toolbox)
