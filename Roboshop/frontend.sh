#!/bin/bash
LOG=/tmp/roboshop.log
echo -e "installing Nginx\t\t...\t\e[32mdone\e[0m"
yum install nginx -y >>$LOG
###1. Out from command shoud not be displayed
###2. Validate the command is successfull or not

echo "enabling Nginx"
systemctl enable nginx >>$LOG
echo "starting Nginx"
systemctl start nginx >>$LOG
