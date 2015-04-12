#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/03_ip_netns.sh"
source "$WORK_HOME/include/05_process.sh"

DIR_LOG="/tmp/iperf/server"
mkdir -p $DIR_LOG

run_iperf_server() {
  local NS_NAME=$1
  local PIDs=$2
  local SEQ=$3

  local IPERF_LOG="$DIR_LOG/iperf-server-${NS_NAME}.log"
  iperf_tcp_server_netns $NS_NAME $IPERF_LOG

  record_pid $PIDs $SEQ $!
  sleep 1
}

declare -a IPERF_PID; SEQ=0
PID_FILE="/tmp/iperf-server-${TEST_ID}.pid"

run_iperf_server $ORG_NS IPERF_PID $SEQ
run_iperf_server $RED_NS IPERF_PID $(($SEQ + 1))

export_pid IPERF_PID[@] $PID_FILE
