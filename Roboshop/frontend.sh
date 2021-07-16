#!/bin/bash

source common.sh    ##to execute from another script
print "installing Nginx\t"
yum install nginx -y &>>$LOG
STATUS_CHECK $?
print "Download frontend\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
STATUS_CHECK $?

print "Remove old HTdocs\t"
cd /usr/share/nginx/html &>>$LOG && rm -rf * &>>$LOG
STATUS_CHECK $?

print "Extract frontend and archieve"
unzip /tmp/frontend.zip &>>$LOG && mv frontend-main/* . &>>$LOG && mv static/* . &>>$LOG && rm -rf frontend-master static &>>$LOG
STATUS_CHECK $?

print "update roboshop config\t"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
STATUS_CHECK $?
###echo $?   ### to print the exist status

print "enabling Nginx\t\t"
systemctl enable nginx &>>$LOG
STATUS_CHECK $?
###echo $?

print "starting Nginx\t\t"
systemctl restart nginx &>>$LOG
STATUS_CHECK $?
###echo $?