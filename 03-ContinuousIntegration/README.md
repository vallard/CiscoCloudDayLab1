# Module 3: Continous Integration
[Home](https://github.com/vallard/CiscoCloudDayLab1)

The first two modules got us working with APIs, Git, and Docker.  In this module
we will tie all of it together with some helpful bots.  In this case
our bot will be [Jenkins](https://jenkins-ci.org).  

We're going to create a fun website.  This website will be front-ended with a
load balancer that will then direct traffic to some of our instances.  

When ever we push new code, our robot will take the code out of gitlab run
some tests, and then push the new code into production.  

## 3.1 Configure Gitlab

Create a new account on Gitlab.  The instructor will give you the URL
of where to sign in to create this account.  The account name can be
anything you like (your name, CEC, etc). 

![Sign up for Gitlab](./images/gl01.png)

Enter a random password.  Let the administrator know that you have created
the account.  They will then confirm your account so that you can login
without having to check your email.  

Once they have notified you that your account has been confirmed, log into
gitlab.  

![Login to Gitlab](./images/gl02.png)

### 3.1.1 Initial project creation

After logging in you will create a new project so that you can upload code
to this source control repository. 

Create a new project by clicking the green _New Project_ button. Call it _web_


You can leave all the default settings and give it a brief description. 

![Create project](./images/gl03.png)

Once this is created, you'll get an error message that shows you that you
can't push or pull code because you haven't entered any SSH keys.  

![No SSH keys](./images/gl04.png)

### 3.1.2 Setup SSH keys

On the left menu, click on the _Profile Settings_ 

![Profile Settings](./images/gl05.png)

The side menu changes and you should see the _SSH Keys_ menu item in the 
sidebar.  Click on it. 

Click the green button to add an SSH key. We'll come back to this screen
after completing the next step. 

#### 3.1.2.1 Generate SSH key

Log back into the lab machine and generate a new SSH key to be used by 
this lab user. Run the command:

```
ssh-keygen -t rsa
```
and just hit the 'enter' button at all the questions.  

This will create two keys inside your ```~/.ssh``` directory.  One key is
the public key ```id_rsa.pub``` and the other key ```id_rsa``` is your 
private key.  We are going to paste the contents of the ```id_rsa.pub```
key to the Gitlab web page we have open now. 

```
cat ~/.ssh/id_rsa.pub
... < your key >
```
Copy and paste this into the browser.  

#### 3.1.2.2 Install SSH key into Gitlab

![enter SSH key into browser](./images/gl06.png)

Clicking 'Add Key' should save the key into your account.

## 3.1.3 Clone Repository

* From the left side menu select _Back to dashboard_

* From the projects menu select your _web_ project.  You will then be taken
to a page that has information on how to start up the project.  

![project web page](./images/gl07.png)

At this point we are going to take a public repository that already has
code and copy it into our newly created private repo.  This is done by
executing the following: 

```
git clone https://github.com/vallard/go-webapp.git
cd go-webapp
```
Now we want to change the remote origin from Github to our local Gitlab
account.  To do this, we first configure some global settings: 
```
git config --global user.name "<gitlab username>"
git config --global user.email "<gitlab email>"
```
Where ```<gitlab username>``` is the user name you signed into Gitlab with. 

Now, we will remove the Github origin
```
git remote remove origin
```
Then we will add the Gitlab origin and commit the code up:
```
git remote add origin ssh://git@ci:10022/vallard/web.git
git add . 
git push -u origin master
```
Refreshing your webpage you should see some of the new content. 

![new web application](./images/gl08.png)

You'll notice our gitlab is configured to show ```localhost```.  For access
from our lab workstations we can simply replace ```localhost``` with ```ci```

Now that we have our application into Gitlab and we can commit and pull
changes.  Let's hook it up to Jenkins so we can deploy services. 

## 3.2 Configure Jenkins


 
