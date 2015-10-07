#!/bin/bash

source "00_check_input.sh"

#---------------------------------------------------------------------------------------------
# 노드에 대해 모니터링 툴을 실행 
# 1) ifstat-max.sh
# 2) loadavg-max.sh
# 3) count_conntrack.sh
#---------------------------------------------------------------------------------------------

usage() {
  echo "Usage: $0 [DST_NODE] [REC_DIR]"
  echo "   ex) $0 onebox03 /tmp/perf/exp-1234"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

#----------------------------------------------------------------------------------------------
DST_NODE=$1
#----------------------------------------------------------------------------------------------

if [ ! -z $2 ]; then
  DIR_REC=$2
else
  DIR_REC="${REC_DIR}/${DST_NODE}"
fi
mkdir -p ${DIR_REC}

cmd="scp -r $DST_NODE:/tmp/perf/* ${DIR_REC}/${DST_NODE}"
run_commands_no_ret $cmd

cmd="ssh $DST_NODE \"rm -rf /tmp/perf/*\""
run_commands_no_ret $cmd
