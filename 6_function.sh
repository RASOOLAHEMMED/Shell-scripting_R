#!/usr/bin/env bash
## Declare a function

sample() {
  echo Hello , i am a simple function
  echo value of a = ${a}
  b=200
  echo first argument in function=$1
}

## main program
## call the fucntion

a=100
sample
echo value of b = ${b}
echo first argument in function=$1