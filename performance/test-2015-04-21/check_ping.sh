#!/bin/bash

source "00_check_input.sh"

# LOG STRING= "TOTAL= 1 OK= 1 ERROR= 0"
# if TOTAL == OK, then return 1
# else return -1

check_ping_result() {
  local LOG=$1

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
}

check_ping() {
  while true; do
    eval "run_remote_cmd $LOC $SCRIPT" &> $LOG
    RESULT=$(check_ping_result $LOG)
    if [ $RESULT -eq 1 ]; then
      echo "OK!!!"
      break
    else 
      echo "ERROR!!! Wait for 10 sec and retry..."
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
LOG="1-vm/trial-1/ping-mgmt/ping-mgmt.log"

check_ping_mgmt $LOC $SCRIPT $LOG 

LOC="~/bin/performance/iperf-netns"
SCRIPT="39_client_ping_gw_batch.sh"
LOG="1-vm/trial-1/02-ping-data.log"

check_ping_data $LOC $SCRIPT $LOG 
