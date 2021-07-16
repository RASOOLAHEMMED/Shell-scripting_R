#!/bin/bash
LOG=/tmp/roboshop.log
rm -f $LOG   ###to keep latest log
echo -n -e "installing Nginx\t\t... "
yum install nginx -y &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32mDone\e[0m"
else
    echo Fail
fi

###echo $?   ### to print the exist status
###3. need to validate script running with root user or not

echo "enabling Nginx"
systemctl enable nginx &>>$LOG
echo $?
echo "starting Nginx"
systemctl start nginx &>>$LOG
echo $?
