#!/bin/bash
LOG=/tmp/roboshop.log
rm -f $LOG   ###to keep latest log

echo -n -e "installing Nginx\t\t..."
yumm install nginx -y &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32mDone\e[0m"
else
    echo -e "\e[31mFail\e[0m"
    exit 1
fi

###echo $?   ### to print the exist status
###3. need to validate script running with root user or not

echo -n -e "enabling Nginx\t\t\t..."
systemctl enable nginx &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32mDone\e[0m"
else
    echo -e "\e[31mFail\e[0m"
    exit 1   ### if fail need to come out with script
fi
###echo $?

echo -n -e "starting Nginx\t\t\t..."
systemctl start nginx &>>$LOG
if [ $? -eq 0 ]; then
  echo -e "\e[32mDone\e[0m"
else
    echo -e "\e[31mFail\e[0m"
    exit 1
fi
###echo $?
