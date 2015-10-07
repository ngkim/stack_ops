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


./01_start_monitor.sh $CONFIG

if [ $IPERF_TEST -eq 1 ]; then
  TIME_WAIT=`echo ${IPERF_DURATION}+5 | bc`
  ./02_start_iperf.sh $CONFIG
  sleep ${TIME_WAIT}
fi
if [ $AB_TEST -eq 1 ]; then
  ./03_start_ab.sh $CONFIG
fi

