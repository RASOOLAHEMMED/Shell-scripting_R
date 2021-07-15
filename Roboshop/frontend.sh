#!/bin/bash
echo -e "installing Nginx\t\t...\t\e[32mdone\e[0m"
yum install nginx -y

echo "enabling Nginx"
systemctl enable nginx

echo "starting Nginx"
systemctl start enginx
