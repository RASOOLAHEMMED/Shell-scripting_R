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
  echo -n -e "$1\t\t..."
}  ###to replace with echo command to print


