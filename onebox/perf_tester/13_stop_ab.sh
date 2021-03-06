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

stop-ab-client() {
  cd 04-ab
  
  print_msg "stop ab client" 
  ./09_stop_ab.sh $CONFIG_REAL_PATH

  cd - &> /dev/null
}

stop-ab-client

