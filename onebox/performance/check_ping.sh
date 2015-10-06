#!/bin/bash

source "00_check_input.sh"

# LOG STRING= "TOTAL= 1 OK= 1 ERROR= 0"
# if TOTAL == OK, then return 1
# else return -1

check_ping_result() {
  local LOG=$1

  if [ -f $LOG ]; then
    tail -n 1 $LOG | awk  '
      BEGIN {
        result=0
      } 
      {
        if ( $2 == $4 ) {
          result = 1
        } else {
          result = -1
        }
      }
      END {
        printf ("%d\n", result);
      }'
  else 
    # file not exist
    echo -2
  fi
}

check_ping() {
  local cmd_to_run=$1
 
  local LOC=$2
  local SCRIPT=$3
  local LOG=$4

  while true; do
    eval "$cmd_to_run $LOC $SCRIPT" &> $LOG
    RESULT=$(check_ping_result $LOG)
    if [ $RESULT -eq 1 ]; then
      echo "OK!!!"
      break
    else 
      echo "ERROR($RESULT)!!! Wait for 10 sec and retry..."
      sleep 10
    fi
  done
}

check_ping_mgmt() {
  local LOC=$1
  local SCRIPT=$2
  local LOG=$3

  check_ping run_remote_cmd $LOC $SCRIPT $LOG
}

check_ping_data() {
  local LOC=$1
  local SCRIPT=$2
  local LOG=$3

  check_ping run_local_cmd $LOC $SCRIPT $LOG
}

LOC="~/bin/openstack/make_100_vms"
SCRIPT="39_ping_vm_mgmt_batch.sh"
LOG=$LOG_PING_MGMT

print_msg "1. check MGMT connectivity" 
check_ping_mgmt $LOC $SCRIPT $LOG 

LOC="~/bin/performance/iperf-netns"
SCRIPT="39_client_ping_gw_batch.sh"
LOG=$LOG_PING_GW

print_msg "2. check DATA connectivity - gateway" 
check_ping_data $LOC $SCRIPT $LOG 

LOC="~/bin/performance/iperf-netns"
SCRIPT="39_client_ping_red_batch.sh"
LOG=$LOG_PING_RED

print_msg "3. check DATA connectivity - red" 
check_ping_data $LOC $SCRIPT $LOG 
