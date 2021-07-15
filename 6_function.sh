#!/usr/bin/env bash
## Declare a function

sample() {
  echo Hello , i am a simple function
  echo value of a = ${a}
  b=200
}

## call the fucntion

a=100
sample
echo value of b = ${b}