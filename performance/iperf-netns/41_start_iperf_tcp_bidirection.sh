#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/03_ip_netns.sh"
source "$WORK_HOME/include/05_process.sh"

DUR=180

DIR_LOG="/tmp/iperf/client"
mkdir -p $DIR_LOG

run_iperf_client() {
  local NS_NAME=$1
  local PIDs=$2
  local SEQ=$3
  local DST_ADDR=$4
  local OPTS=${@:5:$#}

  local IPERF_LOG="$DIR_LOG/iperf-client-${NS_NAME}.log"
  iperf_tcp_client_netns $NS_NAME $DST_ADDR $OPTS &> $IPERF_LOG &

  record_pid $PIDs $SEQ $!
  sleep 0.3
}

declare -a IPERF_PID; SEQ=0
PID_FILE="/tmp/iperf-client-${TEST_ID}.pid"

run_iperf_client $ORG_NS IPERF_PID $SEQ $RED_ADDR_ "-t $DUR -P 3" 
run_iperf_client $RED_NS IPERF_PID $SEQ $ORG_ADDR_ "-t $DUR -P 3"

export_pid IPERF_PID[@] $PID_FILE
