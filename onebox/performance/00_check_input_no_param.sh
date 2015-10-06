#!/bin/bash

WORK_HOME=$HOME/workspace/stack_ops/onebox

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

  cmd="cd $LOC; ./$SCRIPT $START $END; cd -"
  run_commands_no_ret $cmd
