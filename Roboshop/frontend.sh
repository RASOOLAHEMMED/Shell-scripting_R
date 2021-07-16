#!/bin/bash

source common.sh    ##to execute from another script
print "installing Nginx"
yum install nginx -y &>>$LOG
STATUS_CHECK $?

###echo $?   ### to print the exist status
###3. need to validate script running with root user or not

print "enabling Nginx\t"
systemctl enable nginx &>>$LOG
STATUS_CHECK $?
###echo $?

print "starting Nginx\t"
systemctl start nginx &>>$LOG
STATUS_CHECK $?
###echo $?
