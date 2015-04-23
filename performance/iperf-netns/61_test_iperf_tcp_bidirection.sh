#!/bin/bash

source "00_check_input_batch.sh"
source "$WORK_HOME/include/03_ip_netns.sh"
source "$WORK_HOME/include/05_process.sh"

for i in `seq $START $END`; do
  cmd="./41_start_iperf_tcp_bidirection.sh $i"
  run_commands $cmd
#  sleep 0.5
done

