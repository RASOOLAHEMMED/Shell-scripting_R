#!/bin/bash

echo -e "installing Nginx\t\t...\t\e[32mdone\e[0m"
yum install nginx -y
###1. Out from command shoud not be displayed
###2. Validate the command is successfull or not

echo "enabling Nginx"
systemctl enable nginx
echo "starting Nginx"
systemctl start nginx
