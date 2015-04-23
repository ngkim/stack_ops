#!/bin/bash

WORK_HOME=$HOME/bin
IPERF_HOME=$HOME/bin/performance/iperf-netns

C_NODE=a2
cmd_ssh="ssh -tq -o \"BatchMode yes\" $C_NODE"
cmd_ssh_no_color="ssh $C_NODE"
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

  cmd="cd $LOC; ./$SCRIPT $START $END; cd -"
  run_commands_no_ret $cmd
}

if [ -z $2 ]; then
  echo "Usage: $0 [START] [END] [TEST_ID]"
  echo "   ex) $0 0 9 10"
  exit
fi

START=$1
END=$2
TEST_ID=$3

TIME_WAIT_IPERF=30

NUM_VM=$(($END - $START + 1))

DIR_LOG_ROOT="${NUM_VM}-vm"
DIR_LOG="${DIR_LOG_ROOT}/trial-${TEST_ID}"

DIR_LOG_VM="${DIR_LOG}/vm"
DIR_LOG_COUNTER="${DIR_LOG}/counter"
DIR_LOG_PING="${DIR_LOG}/ping"
DIR_LOG_IPERF="$DIR_LOG/iperf"

mkdir -p $DIR_LOG
mkdir -p $DIR_LOG_VM
mkdir -p $DIR_LOG_COUNTER
mkdir -p $DIR_LOG_PING
mkdir -p $DIR_LOG_IPERF

LOG_VM_CREATE="$DIR_LOG_VM/01_vm_create.log"
LOG_VM_DELETE="$DIR_LOG_VM/02_vm_delete.log"
LOG_COUNTER="$DIR_LOG_COUNTER/counter.log"
LOG_PING_MGMT="$DIR_LOG_PING/01_ping-mgmt.log"
LOG_PING_GW="$DIR_LOG_PING/02_ping-gw.log"
LOG_PING_RED="$DIR_LOG_PING/03_ping-red.log"
LOG_IPERF_SERVER="$DIR_LOG_IPERF/04_iperf_server.log"
LOG_IPERF_CLIENT="$DIR_LOG_IPERF/05_iperf_client.log"
LOG_IPERF_SERVER_STOP="$DIR_LOG_IPERF/06-iperf-server-stop.log"
LOG_REMOTE_COUNTER="counter.log"

LOC_IPERF="~/bin/performance/iperf-netns"
