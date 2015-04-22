#!/bin/bash

flavor-create() {
  local ID=$1
  local NAME=$2
  local CPU=$3
  local RAM=$4
  local DISK=$5
  local RXTX=$6

  nova flavor-create --is-public true $NAME $ID $RAM $DISK $CPU --rxtx-factor $RXTX
}

#flavor-create 6 \
#              m1.utm \
#              4 \
#              4096 \
#              20 \
#              1.0 

flavor-create 7 \
              m1.utm.large \
              6 \
              4096 \
              20 \
              1.0 
