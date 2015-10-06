#!/bin/bash

########################################
# Author: Namgon Kim (day10000@gmail.com)
# Date: 2015.10.06
# Desc: print max rx/tx value of ifstat
########################################

usage() {
  echo "Usage: $0 [DEV]"
  echo "   ex)$0 eth0"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

DEV=$1

ifstat -b -i $DEV -n | awk '
/BEGIN/ {
  max_rx=0.0
  max_tx=0.0
}
{
  if ($1 ~ /^[0-9]/) {
    if (max_rx < $1 ) { max_rx = $1 }
    if (max_tx < $2 ) { max_tx = $2 }
    printf("rx= %10.2f tx= %10.2f max_rx= %10.2f max_tx= %10.2f\n", $1, $2, max_rx, max_tx);
  } else {
    print $0
  }
}'
