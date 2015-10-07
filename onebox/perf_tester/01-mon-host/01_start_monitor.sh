#!/bin/bash

source "00_check_input.sh"

#---------------------------------------------------------------------------------------------
# 노드에 대해 모니터링 툴을 실행 
# 1) ifstat-max.sh
# 2) loadavg-max.sh
# 3) count_conntrack.sh
#---------------------------------------------------------------------------------------------

usage() {
  echo "Usage: $0 [DST_NODE] [DEV_LIST]"
  echo "   ex) $0 onebox03 eth11,eth12"
  exit 1
}

if [ -z $2 ]; then
  usage
fi

#----------------------------------------------------------------------------------------------
DST_NODE=$1
DEV_LIST=$2
#----------------------------------------------------------------------------------------------

cmd="ssh $DST_NODE \"mkdir -p $LOG_DIR\""
run_commands_no_ret $cmd

IFS=','
for dev in $DEV_LIST; do
  echo "- ifstat DEV= $dev"
  cmd="ssh $DST_NODE \"cd /root/workspace/stack_ops/pktstat; ./ifstat-max.sh $dev ${LOG_DIR}/${dev}.dump &> /dev/null &\""
  run_commands_no_ret $cmd
done

echo "- load average"
cmd="ssh $DST_NODE \"cd /root/workspace/stack_ops/pktstat; ./loadavg-max.sh &> ${LOG_DIR}/loadavg.dump &\""
run_commands_no_ret $cmd

echo "- conntrack"
cmd="ssh $DST_NODE \"cd /root/workspace/stack_ops/conntrack; ./count-conntrack.sh &> ${LOG_DIR}/conntrack.dump &\""
run_commands_no_ret $cmd
