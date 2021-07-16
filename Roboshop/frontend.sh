#!/bin/bash
LOG=/tmp/roboshop.log
rm -f $LOG   ###to keep latest log
echo -e "installing Nginx\t\t\t... "
yum install nginx -y &>>$LOG
if [ $? -eq 0 ]; then
  echo Done
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
