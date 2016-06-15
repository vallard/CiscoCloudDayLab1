#!/bin/bash
set -x 
sleep 30 # wait a big before we begin this madness. 
mkdir /home/core/java
mkdir /home/core/jenkins
cd /home/core/java
wget -O java.tar.gz http://javadl.sun.com/webapps/download/AutoDL?BundleId=83376
tar xzvf java.tar.gz
rm java.tar.gz
rm /home/core/.bashrc
echo 'export PATH=$PATH:/home/core/java/jre1.7.0_51/bin/' > /home/core/.bashrc
mkdir -p /home/core/.ssh/authorized_keys.d
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtfmSw93x5VBYJkE4UoMMnC97wr9JBaz7I5mHiN7GMAr3UtkdMtcHCt34jddi/x+hoD5LGH+3lXB8Gcu+EZT0TRFf2XrAfzOFrKz99yGTG1KyyPW/SESM4lONmyuqam6/n7QCBsl/hBWn29MtikG1hjavFvTZX6A6BYLOXXTeycJ0R3jBfcB9LycIhFsrF85EnnmfovCyNbebKrTY5y1aSDGgl45dawCUCPEVuETA/eAZAJ4PIY6dIKm73GpxqZMngPx7prh8/dl0/cdLs4758BDJXMxsJSvoHXjXqXsKL+iHC+uw1AUI5DK7BhzjlqZ+tm5V1IGNWDZKX+Hz2Au1r' >/home/core/.ssh/authorized_keys.d/jenkins
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtfmSw93x5VBYJkE4UoMMnC97wr9JBaz7I5mHiN7GMAr3UtkdMtcHCt34jddi/x+hoD5LGH+3lXB8Gcu+EZT0TRFf2XrAfzOFrKz99yGTG1KyyPW/SESM4lONmyuqam6/n7QCBsl/hBWn29MtikG1hjavFvTZX6A6BYLOXXTeycJ0R3jBfcB9LycIhFsrF85EnnmfovCyNbebKrTY5y1aSDGgl45dawCUCPEVuETA/eAZAJ4PIY6dIKm73GpxqZMngPx7prh8/dl0/cdLs4758BDJXMxsJSvoHXjXqXsKL+iHC+uw1AUI5DK7BhzjlqZ+tm5V1IGNWDZKX+Hz2Au1r' >/home/core/.ssh/authorized_keys

echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClA3wJlVefBxgGnkfylfDNXHx91Wx/5pe2T4uJBDbTtXM5afDO7RcMeq1i0bqQzLerZ94Mt0JK8hGmA1JQv6WLySIE+aUwrMAmzlWGYwGRGHtVV6oC4iZ0xbF1Vvyw8iKKBX4VsZVvFafWUkz53WRMT7tskiAc7ApfctNxcTNNZqKZZdxm9amZurLIYfkJO3hRlCN6P/bxH4iC/6zLPzJuAhRo28mhMmpZIQea5EtzgYisPQwhXwqOh1rJVXKjBv8ck375fc1ueJ1SgiT2fK4bBnGK/gKi9uULRG7dAuGpI9Au4ehnK2EShs65r/oZKegkAXeDiKbJPqRl0x7Bi8ip' >> /home/core/.ssh/authorized_keys.d/jenkins
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClA3wJlVefBxgGnkfylfDNXHx91Wx/5pe2T4uJBDbTtXM5afDO7RcMeq1i0bqQzLerZ94Mt0JK8hGmA1JQv6WLySIE+aUwrMAmzlWGYwGRGHtVV6oC4iZ0xbF1Vvyw8iKKBX4VsZVvFafWUkz53WRMT7tskiAc7ApfctNxcTNNZqKZZdxm9amZurLIYfkJO3hRlCN6P/bxH4iC/6zLPzJuAhRo28mhMmpZIQea5EtzgYisPQwhXwqOh1rJVXKjBv8ck375fc1ueJ1SgiT2fK4bBnGK/gKi9uULRG7dAuGpI9Au4ehnK2EShs65r/oZKegkAXeDiKbJPqRl0x7Bi8ip' >> /home/core/.ssh/authorized_keys

chmod 600 /home/core/.ssh/authorized_keys
chmod 600 /home/core/.ssh/authorized_keys.d/jenkins
chmod 700 /home/core/.ssh/authorized_keys.d

sudo echo '10.100.0.38 ci' >/etc/hosts
# setup insecure registry
sudo systemctl daemon-stop
sudo systemctl stop docker
sudo mkdir -p /etc/systemd/system/
sudo touch /etc/systemd/system/docker.service
sudo ls -l /etc/systemd/system/docker.service
echo '
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com
After=docker.socket early-docker.target network.target
Requires=docker.socket early-docker.target

[Service]
Environment=TMPDIR=/var/tmp
EnvironmentFile=-/run/flannel_docker_opts.env
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
#ExecStart=/usr/lib/coreos/dockerd --daemon --host=fd:// --insecure-registry 208.90.61.59:5000 $DOCKER_OPTS $DOCKER_OPT_BIP $DOCKER_OPT_MTU $DOCKER_OPT_IPMASQ
#ExecStart=/usr/lib/coreos/dockerd --daemon --host=fd:// --insecure-registry 208.90.61.59:5000 --insecure-registry 10.100.0.38:5000 --insecure-registry ci:5000 
ExecStart=/usr/lib/coreos/dockerd daemon --host=fd:// $DOCKER_OPTS $DOCKER_CGROUPS $DOCKER_OPT_BIP $DOCKER_OPT_MTU $DOCKER_OPT_IPMASQ --insecure-registry 208.90.61.59:5000

[Install]
WantedBy=multi-user.target
' >/home/core/docker.sh

cat /home/core/docker.sh
sudo mv /home/core/docker.sh /etc/systemd/system/docker.service
sudo chown root:root /etc/systemd/system/docker.service
#sudo systemctl restart docker
