#!/usr/bin/env bash
LOG=/tmp/roboshop.log
rm -f $LOG   ###to keep latest log

### To find out the which user to execute
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
  echo -e "\e[33myou should be root user / sudo user to run this script\e[0m"
  exit 2
fi

STATUS_CHECK() {
  if [ $1 -eq 0 ]; then
  echo -e "\e[32mDone\e[0m"
else
    echo -e "\e[31mFail\e[0m"
    echo -e "\e[33m check the file for more details,log file-$LOG\e[0m"
    exit 1
fi
}

print() {
  echo -e "\n########################\t$1\t########################" &>>$LOG
  echo -n -e "$1\t\t..."
}  ###to replace with echo command to print

#################################user and catalogue resuebulity ##############################################

add_application_user() {
print "Add roboshop application user"
id roboshop &>>$LOG
if [ $? -ne 0 ]; then
useradd roboshop &>>$LOG
fi
STATUS_CHECK $?
}

Download_extraction_app_code() {
  print "Download application\t"
curl -s -L -o /tmp/${component}.zip "https://github.com/roboshop-devops-project/${component}/archive/main.zip" &>>$LOG
STATUS_CHECK $?

print "Extract Downloaded code\t"
cd /home/roboshop && unzip -o /tmp/${component}.zip &>>$LOG && rm -rf ${component} && mv ${component}-main ${component}
STATUS_CHECK $?

}

permission_fix() {
  print "Fix application permissions"
chown roboshop:roboshop /home/roboshop -R &>>$LOG
STATUS_CHECK $?
}

setup_systemd() {
  print "setup systemd file\t"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" -e "s/REDIS_ENDPOINT/redis.roboshop.internal/" -e "s/MONGO_ENDPOINT/mongodb.roboshop.internal/" -e "s/CATALOGUE_ENDPOINT/catalogue-frontend.roboshop.internal/" -e "s/CARTENDPOINT/cart.roboshop.internal/" -e "s/DBHOST/mysql.roboshop.internal/" /home/roboshop/${component}/systemd.service && mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service
STATUS_CHECK $?

print "Start ${component} service\t"
systemctl daemon-reload &>>$LOG && systemctl restart ${component} &>>$LOG && systemctl enable ${component} &>>$LOG
STATUS_CHECK $?
}

nodejs() {

add_application_user

print "Install NodeJS\t\t"
yum install nodejs make gcc-c++ -y &>>$LOG
STATUS_CHECK $?

Download_extraction_app_code

print "Install NodeJS dependencies"
cd /home/roboshop/${component} && npm install --unsafe-perm &>>$LOG
STATUS_CHECK $?

permission_fix

setup_systemd

}

java() {
  print "Install Maven\t\t"
  yum install maven -y &>>$LOG
  STATUS_CHECK $?

add_application_user

Download_extraction_app_code

print "compile code\t\t"
cd /home/roboshop/${component} && mvn clean package &>>$LOG && mv target/shipping-1.0.jar shipping.jar
STATUS_CHECK $?

permission_fix

setup_systemd


}

python3() {
print "Install python3\t\t"
yum install python36 gcc python3-devel -y &>>$LOG
STATUS_CHECK $?

add_application_user

Download_extraction_app_code

print "Install python dependencies"

cd /home/roboshop/${component} && pip3 install -r requirements.txt &>>$LOG
STATUS_CHECK $?

print "update serviceconfig"
uid=$(id -u roboshop)
gid=$(id -g roboshop)
sed -i -e "/uid/ c uid=${uid}" -e "/gid/ c gid=${gid}' payment.ini &>>$LOG
STATUS_CHECK $?
permission_fix

#setup_systemd

}