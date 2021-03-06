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

mon-host() {
  cd 01-mon-host
  for node in "${NODE_LIST[@]}"; do
    node_name=`echo $node | awk '{print $1}'`
    node_intf=`echo $node | awk '{print $2}'`
  
    print_msg "${node_name}: start_monitor $node_intf" 
    ./01_start_monitor.sh ${node_name} ${node_intf}
  done
  cd - &> /dev/null
}

mon-utm() {
  cd 02-mon-utm
  print_msg "${UTM}: start_monitor..." 
  ./01_start_monitor_vUTM.sh $UTM
  cd - &> /dev/null
}

mon-host
mon-utm

