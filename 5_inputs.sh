#!/usr/bin/bash

## inputs can be loaded using special variables
## 0-n,*,@,#

## in script if you want access script name (bash 5_inputs.sh xyz 123) then
echo $0
##$1 is the first argument and $n is the nth argument
echo $1
## Pull all the passed values (bash 5_inputs.sh xyz 123)
echo $*
echo $@
## number of values passed is
echo $#