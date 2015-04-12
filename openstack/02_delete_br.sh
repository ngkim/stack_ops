#!/bin/bash

BR_LIST=`brctl show | grep "8000.000000000000" | grep -v virbr | awk '{print $1}'` 

for b in $BR_LIST; do
  echo $b
  ifconfig $b down
  brctl delbr $b
done

