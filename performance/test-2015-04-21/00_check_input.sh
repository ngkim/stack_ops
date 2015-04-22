#!/bin/bash

WORK_HOME=$HOME/bin
IPERF_HOME=$HOME/bin/performance/iperf-netns

C_NODE=a2
cmd_ssh="ssh -tq -o \"BatchMode yes\" $C_NODE"
cmd_scp="scp $C_NODE"

source "$WORK_HOME/include/command_util.sh"

run_remote_cmd() {
  local LOC=$1
  local SCRIPT=$2

  cmd="$cmd_ssh \"cd $LOC; ./$SCRIPT $START $END\""
  run_commands_no_ret $cmd
}

run_local_cmd() {
  local LOC=$1
  local SCRIPT=$2

  cmd="cd $LOC; ./$SCRIPT $START $END"
  run_commands_no_ret $cmd
}

if [ -z $2 ]; then
  echo "Usage: $0 [START] [END]"
  echo "   ex) $0 0 9"
  exit
fi

START=$1
END=$2
