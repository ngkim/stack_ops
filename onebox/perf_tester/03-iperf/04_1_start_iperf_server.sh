#!/bin/bash

source "00_check_input.sh"

#---------------------------------------------------------------------------------------------
# 노드에 대해 모니터링 툴을 실행 
# 1) ifstat-max.sh
# 2) loadavg-max.sh
# 3) count_conntrack.sh
#---------------------------------------------------------------------------------------------

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

#----------------------------------------------------------------------------------------------
# SERVER
#----------------------------------------------------------------------------------------------

cmd="ssh $IPERF_SERVER_HOST \"mkdir -p ${LOG_DIR_IPERF}\""
run_commands_no_ret $cmd

cmd="ssh $IPERF_SERVER_HOST \"ip netns exec ${IPERF_SERVER_NS} iperf -s -p $IPERF_SERVER_DATA_PORT $IPERF_SERVER_OPTS &> ${LOG_DIR_IPERF}/iperf-server.dump &\""
run_commands_no_ret $cmd

