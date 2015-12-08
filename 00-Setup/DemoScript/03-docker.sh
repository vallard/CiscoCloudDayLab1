#!/bin/bash
echo "https://hub.docker.com/r/vallard/metaclient/"
read -n1 -r

echo "docker ps"
read -n1 -r
docker ps
echo "Hmm... doesn't work"
read -n1 -r

echo "docker-machine ls"
read -n1 -r
docker-machine ls

echo "docker-machine env loco"
read -n1 -r
docker-machine env loco

read -n1 -r
echo "docker images"
echo "docker ps"
echo "docker run -d --name nginx -p 80:80 nginx"
