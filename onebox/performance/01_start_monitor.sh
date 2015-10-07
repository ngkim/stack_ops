#!/bin/bash

source "00_check_input_no_param.sh"

# 각 노드에 대해 모니터링 툴을 실행 
usage() {
  echo "Usage: $0 [DST_NODE] [DEV] [FILENAME]"
  echo "   ex) $0 onebox03 eth11 eth11.dump"
  exit 1
}

if [ -z $3 ]; then
  usage
fi

DST_NODE=$1
DEV=$2
FILENAME=$3

cmd="ssh $DST_NODE \"cd /root/workspace/stack_ops/pktstat; ./ifstat-max.sh $DEV $FILENAME\""
run_commands_no_ret $cmd
