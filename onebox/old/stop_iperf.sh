#!/bin/bash

source "00_check_input.sh"

run_iperf() {
  local LOC=$1
  local SCRIPT=$2
  local LOG=$3

  #eval "cd $LOC; $SCRIPT &> $LOG; cd -"
  eval "cd $LOC; $SCRIPT $START $END"
}

SCRIPT_IPERF="./54_stop_iperf_server_tcp_bidirection_batch.sh"

print_msg "1. stop iperf server" 
run_iperf $LOC_IPERF $SCRIPT_IPERF $LOG_IPERF_SERVER_STOP
