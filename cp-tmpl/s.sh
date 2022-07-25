#!/bin/bash

for ((i = 1; ; ++i)); do
  echo $i
  ./gen.py > int 
  diff -w <(./main < int) <(./complete.py < int) || break
done 
