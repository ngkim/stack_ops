#!/bin/bash

########################################
# Author: Namgon Kim (day10000@gmail.com)
# Date: 2015.10.06
# Desc: print max rx/tx value of ifstat
########################################

usage() {
  echo "Usage: $0 [DEV] [FILENAME]"
  echo "   ex)$0 eth0 eth0.dump"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

DEV=$1
FILENAME=$2

ifstat -b -i $DEV -n | awk -v dump=$FILENAME '
/BEGIN/ {
  max_rx=0.0
  max_tx=0.0
}
{
  if ($1 ~ /^[0-9]/) {
    now=systime(); 
    str_now=strftime("%Y-%m-%d %H:%M:%S", now);
    if (max_rx < $1 ) { max_rx = $1 }
    if (max_tx < $2 ) { max_tx = $2 }
    if ( dump != "" ) {
      printf("%-20s rx= %10.2f tx= %10.2f max_rx= %10.2f max_tx= %10.2f\n", str_now, $1, $2, max_rx, max_tx) | "tee "dump
    } else {
      printf("%-20s rx= %10.2f tx= %10.2f max_rx= %10.2f max_tx= %10.2f\n", str_now, $1, $2, max_rx, max_tx)
    }
  } 
}' 
