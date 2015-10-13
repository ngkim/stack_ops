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

if [ ! -z $AB_TEST ] && [ $AB_TEST -eq 1 ]; then
  ./13_stop_ab.sh $CONFIG
fi
if [ ! -z $IPERF_TEST ] && [ $IPERF_TEST -eq 1 ]; then
  ./12_stop_iperf.sh $CONFIG
fi
./11_stop_monitor.sh $CONFIG

