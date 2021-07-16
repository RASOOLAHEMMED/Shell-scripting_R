#!/bin/bash
LOG=/tmp/roboshop.log
rm -f $LOG   ###to keep latest log

STATUS_CHECK() {
  if [ $1 -eq 0 ]; then
  echo -e "\e[32mDone\e[0m"
else
    echo -e "\e[31mFail\e[0m"
    exit 1
fi
}

print() {
  echo -n -e "$1\t\t..."
}  ###to replace with echo command to print

print "installing Nginx"
yum install nginx -y &>>$LOG
STATUS_CHECK $?

###echo $?   ### to print the exist status
###3. need to validate script running with root user or not

print "enabling Nginx"
systemctl enable nginx &>>$LOG
STATUS_CHECK $?
###echo $?

print "starting Nginx"
systemctl start nginx &>>$LOG
STATUS_CHECK $?
###echo $?
