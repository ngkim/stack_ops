#!/bin/bash

source "00_check_input.sh"

run_iperf() {
  local LOC=$1
  local SCRIPT=$2
  local LOG=$3

  #eval "cd $LOC; $SCRIPT &> $LOG; cd -"
  eval "cd $LOC; $SCRIPT $START $END"
}

SCRIPT_IPERF="./44_start_iperf_server_tcp_bidirection_batch.sh"
LOG=$LOG_IPERF_SERVER

print_msg "1. start iperf server" 
run_iperf $LOC_IPERF $SCRIPT_IPERF $LOG

print_msg ".... wait for 10 seconds..."
sleep 10

SCRIPT_IPERF="./61_test_iperf_tcp_bidirection.sh"
LOG=$LOG_IPERF_CLIENT

print_msg "2. start iperf client" 
run_iperf $LOC_IPERF $SCRIPT_IPERF $LOG



