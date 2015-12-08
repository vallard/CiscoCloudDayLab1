#!/bin/bash

echo "# curl -d '{ \"auth\":{\"passwordCredentials\":{\"username\": \"'\"$OS_USERNAME\"'\", \"password\": \"'\"super_secret\"'\" }}}' \
-H \"Content-type: application/json\" -X POST $OS_AUTH_URL/tokens | python -m json.tool"
read -n1 -r 
curl -d '{"auth":{"passwordCredentials":{"username": "'"$OS_USERNAME"'", "password": "'"$OS_PASSWORD"'" }}}' \
-H "Content-type: application/json" -X POST $OS_AUTH_URL/tokens | python -m json.tool

echo "# nova list"
read -n1 -r 
nova list

echo "# nova image-list"
read -n1 -r 
nova image-list

echo "# nova keypair-list"
read -n1 -r 
nova keypair-list

echo "# cinder list"
read -n1 -r
cinder list

echo "# openstack user list"
read -n1 -r 
openstack user list
