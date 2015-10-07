#!/bin/bash

source "00_check_input.sh"

#---------------------------------------------------------------------------------------------
# 노드에 대해 모니터링 툴을 실행 
# 1) ifstat-max.sh
# 2) loadavg-max.sh
# 3) count_conntrack.sh
#---------------------------------------------------------------------------------------------

usage() {
  echo "Usage: $0 [DST_NODE]"
  echo "   ex) $0 onebox03-vUTM"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

#----------------------------------------------------------------------------------------------
DST_NODE=$1
#----------------------------------------------------------------------------------------------

cmd="ssh $DST_NODE \"mkdir -p $LOG_DIR\""
run_commands_no_ret $cmd

echo "- load average"
cmd="ssh $DST_NODE \"cd /root/workspace/stack_ops/pktstat; ./loadavg-max.sh &> ${LOG_DIR}/loadavg.dump &\""
run_commands_no_ret $cmd

echo "- conntrack"
cmd="ssh $DST_NODE \"cd /root/workspace/stack_ops/conntrack; ./count-conntrack.sh &> ${LOG_DIR}/conntrack.dump &\""
run_commands_no_ret $cmd
