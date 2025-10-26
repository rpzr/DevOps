#!/bin/bash

sudo nginx -s reload
sudo kill $(sudo lsof -i :80 | grep -i listen | awk '{print $2}')
sudo kill $(sudo lsof -i :81 | grep -i listen | awk '{print $2}')
sudo kill $(sudo lsof -i :8080 | grep -i listen | awk '{print $2}')

echo "
Building container
"

sudo docker build -t myserver:v1 .

echo "
Checking images
"
sudo docker images

echo "
Running server
"
sudo docker run --rm -d -p 80:81 --name fernandg myserver:v1



echo "
+++++++++++++++Dockle+++++++++++++++
"
sudo dockle -ak NGINX_GPGKEY -ak NGINX_GPGKEY_PATH myserver:v1
echo "
+++++++++++++++Dockle+++++++++++++++
"

echo "
check 127.0.0.1:80 in browser or [curl 127.0.0.1:80], should be Hello World!"
echo "check 127.0.0.1:80/status in browser or [curl 127.0.0.1:80/status], should give info about server"
echo "

[sudo docker stop fernandg] to stop running container"

