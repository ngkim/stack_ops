#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/03_ip_netns.sh"
source "$WORK_HOME/include/05_process.sh"

PID_FILE="/tmp/iperf-client-${TEST_ID}.pid"

for PID in `cat $PID_FILE`; do
  kill_process_tree $PID
done
