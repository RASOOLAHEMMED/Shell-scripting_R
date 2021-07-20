#!/bin/bash

source common.sh

print "Install redis repos\t"
yum install epel-release yum-utils yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
STATUS_CHECK $?

print "install redis\t\t"
yum install redis -y --enablerepo=remi &>>$LOG
STATUS_CHECK $?

print "update redis listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
STATUS_CHECK $?

print "start redis service\t"
systemctl enable redis &>>$LOG && systemctl restart redis &>>$LOG
STATUS_CHECK $?