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

CONFIG_REAL_PATH=`readlink -e ${CONFIG}`
stop-iperf() {
  cd 03-iperf
  
  print_msg "stop iperf server and client" 
  ./06_stop_iperf.sh $CONFIG_REAL_PATH

  cd - &> /dev/null
}

stop-iperf
sleep 3

