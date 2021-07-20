#!/bin/bash
source common.sh

print "Install NodeJS\t\t"
yum install nodejs make gcc-c++ -y &>>$LOG
STATUS_CHECK $?

print "Add roboshop application user"
id roboshop &>>$LOG
if [ $? -ne 0 ]; then
useradd roboshop &>>$LOG
fi
STATUS_CHECK $?

print "Download application\t"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
STATUS_CHECK $?

print "Extract Downloaded code\t"
cd /home/roboshop && unzip -o /tmp/catalogue.zip &>>$LOG && rm -rf catalogue && mv catalogue-main catalogue
STATUS_CHECK $?

print "Install NodeJS dependencies\t"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$LOG
STATUS_CHECK $?

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue