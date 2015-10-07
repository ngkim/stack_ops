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

cmd="ssh $AB_CLIENT_HOST \"mkdir -p ${LOG_DIR_AB}\""
run_commands_no_ret $cmd

cmd="ssh $AB_CLIENT_HOST \"ip netns exec ${AB_CLIENT_NS} ab ${AB_CLIENT_OPTS} ${AB_SERVER_URL} &> ${LOG_DIR_AB}/ab-client.dump\""
run_commands_no_ret $cmd

