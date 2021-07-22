#!/bin/bash

source common.sh

print "setup mysql repos\t"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STATUS_CHECK $?

print "Install MySQL\t\t"
yum install mysql-community-server -y &>>$LOG
STATUS_CHECK $?

print "Start MySQL service\t".
systemctl enable mysqld &>>$LOG && systemctl start mysqld &>>$LOG
STATUS_CHECK $?

print "Reset my sql root password"
default_password=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo "Show databases;" | mysql -uroot -pRoboshop@1 &>>$LOG
if [ $? -ne 0 ]; then
   echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1';" | mysql --connect-expired-password -uroot -p${default_password} &>>$LOG
fi
STATUS_CHECK $?

print "Uninstall mysql password policy"
echo SHOW PLUGINS | mysql -uroot -pRoboshop@1 2>>$LOG | grep -i validate_password &>>$LOG
if [ $? -eq 0 ]; then
  echo "uninstall plugin validate_password;" | mysql -uroot -pRoboshop@1 &>>$LOG
fi
STATUS_CHECK $?

print "Download schema\t\t"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>$LOG
STATUS_CHECK $?

print "Load schema\t\t"
cd /tmp && unzip -o mysql.zip &>>$LOG && cd mysql-main && mysql -uroot -pRoboShop@1 <shipping.sql &>>$LOG
STATUS_CHECK $?