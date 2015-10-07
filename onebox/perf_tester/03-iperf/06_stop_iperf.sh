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

DST_NODE=${IPERF_SERVER_HOST}
exec_kill_netns "iperf" $DST_NODE ${IPERF_SERVER_NS}

DST_NODE=${IPERF_CLIENT_HOST}
exec_kill_netns "iperf" $DST_NODE ${IPERF_CLIENT_NS}
