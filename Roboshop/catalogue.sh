#!/bin/bash
source common.sh

print "Install NodeJS\t\t"
yum install nodejs make gcc-c++ -y &>>$LOG
STATUS_CHECK $?

print "Add roboshop application user"
useradd roboshop &>>$LOG
STATUS_CHECK $?

#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue