#!/bin/bash
## Set up python
PYPY_VERSION=2.4.0
HOME=/home/core
mkdir -p $HOME
cd $HOME
block-until-url https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2
wget -O - https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
mv -n pypy-$PYPY_VERSION-linux64 pypy
## library fixup
mkdir -p pypy/lib
ln -snf /lib64/libncurses.so.5.9 $HOME/pypy/lib/libtinfo.so.5

mkdir -p $HOME/bin
#
cat > $HOME/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH exec $HOME/pypy/bin/pypy "\$@"
EOF
#
chmod +x $HOME/bin/python
$HOME/bin/python --version

wget http://benincosa.com/get-pip.py
sudo $HOME/bin/python ~/get-pip.py

echo '#!/bin/bash
LD_LIBRARY_PATH=/home/core/pypy/lib:$LD_LIBRARY_PATH /home/core/pypy/bin/$(basename $0) $@'>$HOME/bin/pip

chmod 755 $HOME/bin/pip

# use 1.1.0 for the docker client to equal the same version of the server: 1.18 and not get bug. 
sudo $HOME/bin/pip install -I docker-py==1.1.0

# setup 
mkdir -p /etc/systemd/system/
cat > /etc/systemd/system/docker.service <<EOF
[Service]
Environment='DOCKER_OPTS=--insecure-registry=ci:5000 '
EOF

systemctl daemon-reload
systemctl restart docker
