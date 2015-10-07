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

exec_kill "ifstat-max" $DST_NODE
exec_kill "ifstat" $DST_NODE
exec_kill "loadavg-max" $DST_NODE
exec_kill "count-conntrack" $DST_NODE
