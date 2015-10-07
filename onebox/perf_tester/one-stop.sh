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


print_msg_high "1. START!!!"
./start.sh $CONFIG
print_msg_high "2. STOP!!!"
./stop.sh $CONFIG
print_msg_high "3. COLLECT!!!"
./collect.sh $CONFIG
print_msg_high "DONE!!!"

