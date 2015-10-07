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

kill_proc() {
  local PSLIST=$*

  echo "PSLIST= $PSLIST"
  # replace \n to whitespace and remove trailing whitespaces
  PSLIST=`echo $PSLIST | sed ':a;N;$!ba;s/\n/ /g' | sed -e 's/[[:space:]]*$//'`

  IFS=' '
  for ps in $PSLIST; do
    echo "kill ps= $ps"
    cmd="ssh $DST_NODE \"kill $ps\""
    run_commands_no_ret $cmd
  done
}

exec_kill() {
  P_NAME=$1

  echo "=== KILL ${P_NAME}"
  cmd="ssh $DST_NODE \"ps ax | pgrep ${P_NAME}\""
  run_commands $cmd
  kill_proc $RET

  #cmd="ssh $DST_NODE \"ps ax | grep ${P_NAME} | grep -v grep | awk '{print \$1}'\""
  #run_commands $cmd
  #kill_proc $RET
}

exec_kill "ifstat-max"
exec_kill "ifstat"
exec_kill "loadavg-max"
exec_kill "count_conntrck"
