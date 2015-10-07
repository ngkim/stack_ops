kill_process() {
  local PID=$1

  cmd="kill $PID"
  run_commands $cmd
}

kill_process_tree() {
  local PID=$1

  for cPID in `pgrep -P $PID`; do
    kill_process $cPID
  done

  kill_process $PID
  
}

# record PID to an array
record_pid() {
  local arr_name=$1
  local SEQ=$2
  local PID=$3

  echo "$SEC PID= $PID"
  eval "${arr_name}[$SEQ]=$PID"
}

export_pid() {
  declare -a PIDs=("${!1}")
  local PID_FILE=$2

  rm -rf $PID_FILE
  for (( i = 0 ; i < ${#PIDs[@]} ; i++ )) do
        _PID=${PIDs[$i]}
        echo $_PID >> $PID_FILE
  done
}

kill_proc() {
  local PSLIST=$*

  # replace \n to whitespace and remove trailing whitespaces
  PSLIST=`echo $PSLIST | sed ':a;N;$!ba;s/\n/ /g' | sed -e 's/[[:space:]]*$//'`

  IFS=' '
  for ps in $PSLIST; do
    echo "kill ps= $ps"
    cmd="ssh $DST_NODE \"kill $ps\""
    run_commands_no_ret $cmd
  done
}

exec_check() {
  P_NAME=$1
  DST_NODE=$2

  echo "=== CHECK ${P_NAME}"
  cmd="ssh $DST_NODE \"ps ax | grep ${P_NAME} | grep -v grep\""
  run_commands_no_ret $cmd
}

exec_check_netns() {
  local P_NAME=$1
  DST_NODE=$2
  local NS_NAME=$3

  echo "=== CHECK ${P_NAME}"
  cmd="ssh $DST_NODE \"ip netns exec ${NS_NAME} ps ax | grep ${P_NAME} | grep -v grep\""
  run_commands_no_ret $cmd
}

exec_kill() {
  local P_NAME=$1
  DST_NODE=$2

  echo "=== KILL ${P_NAME}"
  cmd="ssh $DST_NODE \"pgrep ${P_NAME}\""
  run_commands $cmd
  kill_proc $RET
}

exec_kill_utm() {
  local P_NAME=$1
  DST_NODE=$2

  echo "=== KILL ${P_NAME}"
  cmd="ssh $DST_NODE \"ps ax | grep ${P_NAME} | grep -v grep\" | awk '{print \$1}'"
  run_commands $cmd
  kill_proc $RET
}

exec_kill_netns() {
  local P_NAME=$1
  DST_NODE=$2
  local NS_NAME=$3

  echo "=== [ $DST_NODE ] KILL ${P_NAME} in ${NS_NAME}"
  cmd="ssh $DST_NODE \"ip netns exec ${NS_NAME} pgrep ${P_NAME}\""
  run_commands $cmd
  PSLIST=$RET

  # replace \n to whitespace and remove trailing whitespaces
  PSLIST=`echo $PSLIST | sed ':a;N;$!ba;s/\n/ /g' | sed -e 's/[[:space:]]*$//'`

  IFS=' '
  for ps in $PSLIST; do
    echo "kill ps= $ps"
    cmd="ssh $DST_NODE \"ip netns exec ${NS_NAME} kill $ps\""
    run_commands_no_ret $cmd
  done
}


