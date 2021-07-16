#!/bin/bash
LOG=/tmp/roboshop.log
rm -f $LOG   ###to keep latest log
echo -e "installing Nginx\t\t...\t\e[32mdone\e[0m"
yum install nginx -y &>>$LOG
echo $?   ### to print the exist status
###1. Out from command shoud not be displayed
###2. Validate the command is successfull or not
###3. need to validate script running with root user or not

echo "enabling Nginx"
systemctl enable nginx &>>$LOG
echo $?
echo "starting Nginx"
systemctl start nginx &>>$LOG
echo $?
