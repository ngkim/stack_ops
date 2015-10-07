#!/bin/bash

source "00_check_input.sh"

#----------------------------------------------------------------------------------------------

usage() {
  echo "Usage: $0 [CONFIG]"
  echo "   ex) $0 config/onebox03.cfg"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

#----------------------------------------------------------------------------------------------
CONFIG=$1
source $CONFIG
#----------------------------------------------------------------------------------------------

./21_check_monitor.sh $CONFIG
./22_check_iperf.sh $CONFIG
./23_check_ab.sh $CONFIG

