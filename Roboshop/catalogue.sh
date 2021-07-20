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

print "Install NodeJS dependencies"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$LOG
STATUS_CHECK $?

print "Fix application permissions"
chown roboshop:roboshop /home/roboshop -R &>>$LOG
STATUS_CHECK $?


print "Update systemd file\t"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
STATUS_CHECK $?

print "Start catalogue service\t"
systemctl daemon-reload &>>$LOG && systemctl start catalogue &>>$LOG && systemctl enable catalogue &>>$LOG