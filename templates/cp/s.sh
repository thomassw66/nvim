#!/bin/bash
make all 

if [ $? != 0 ] then 
  echo "Failed to compile... exiting."
  exit 1
fi 

for ((i = 1; ; ++i)); do
  echo $i
  ./gen.py > int 
  diff -w <(./main < int) <(./complete.py < int) || break
done 
