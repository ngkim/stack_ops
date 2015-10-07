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

stop-mon-host() {
  cd 01-mon-host
  for node in "${NODE_LIST[@]}"; do
    node_name=`echo $node | awk '{print $1}'`
    node_intf=`echo $node | awk '{print $2}'`
  
    print_msg "${node_name}: stop_monitor..." 
    ./03_stop_monitor.sh ${node_name}
  done
  cd - &> /dev/null
}

stop-mon-utm() {
  cd 02-mon-utm
  print_msg "${UTM}: stop_monitor..." 
  ./03_stop_monitor_vUTM.sh $UTM
  cd - &> /dev/null
}

stop-mon-host
stop-mon-utm

