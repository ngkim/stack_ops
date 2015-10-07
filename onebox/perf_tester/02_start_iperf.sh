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
start-iperf-server() {
  cd 03-iperf
  
  print_msg "start iperf server" 
  ./04_1_start_iperf_server.sh $CONFIG_REAL_PATH

  cd - &> /dev/null
}

start-iperf-client() {
  cd 03-iperf
  
  print_msg "start iperf client" 
  ./04_2_start_iperf_client.sh $CONFIG_REAL_PATH

  cd - &> /dev/null
}

start-iperf-server
sleep 3
start-iperf-client
sleep 3

