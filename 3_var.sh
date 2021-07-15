#!/usr/bin/env bash

a=10
echo A=$a
DATE="2021-07-14"
echo Welcome,Today date is $DATE
## command subs
NO_OF_USERS=$(who | wc -l)
echo Number of users = $NO_OF_USERS
##Date with command substitution
DATE=$(date +%F)
echo Welcome Todays date is $DATE
## scalar properity
n=(10 20)
echo for my first value= ${n[0]}
echo for my second value= ${n[1]}