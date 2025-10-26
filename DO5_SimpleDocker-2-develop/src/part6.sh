#!/bin/bash

echo "
Stopping container from Part5 if it's up
"

sudo docker stop fernandg


sudo kill $(sudo lsof -i :80 | grep -i listen | awk '{print $2}')
sudo kill $(sudo lsof -i :81 | grep -i listen | awk '{print $2}')
sudo kill $(sudo lsof -i :8080 | grep -i listen | awk '{print $2}')


echo "
Shutting down all containers
"

sudo docker-compose down

echo "
Building project
"

sudo docker-compose build

echo "
Starting up project
"

sudo docker-compose up