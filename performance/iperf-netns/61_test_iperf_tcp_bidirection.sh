#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/03_ip_netns.sh"
source "$WORK_HOME/include/05_process.sh"

for i in `seq 0 $TEST_ID`; do
  cmd="./41_start_iperf_tcp_bidirection.sh $i"
  run_commands $cmd
#  sleep 0.5
done

