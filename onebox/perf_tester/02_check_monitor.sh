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
  echo "   ex) $0 onebox03"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

#----------------------------------------------------------------------------------------------
DST_NODE=$1
#----------------------------------------------------------------------------------------------

exec_check() {
  P_NAME=$1

  echo "=== CHECK ${P_NAME}"
  cmd="ssh $DST_NODE \"ps ax | grep ${P_NAME} | grep -v grep\""
  run_commands_no_ret $cmd
}

exec_check "ifstat-max" 
exec_check "ifstat" 
exec_check "loadavg-max" 
exec_check "count_conntrack" 
