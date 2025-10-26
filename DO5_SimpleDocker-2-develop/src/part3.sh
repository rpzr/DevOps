#!/bin/bash


sudo kill $(sudo lsof -t -i :81)
sudo kill $(sudo lsof -t -i :8080)
rm -rf ./server/server
gcc ./server/server.c -o ./server/server -lfcgi
spawn-fcgi -p 8080 ./server/server
sudo nginx -c /home/fernandg/DO5_SimpleDocker-2/src/server/nginx.conf
echo "check 127.0.0.1:81 in browser or [curl 127.0.0.1:81], should be Hello World!"