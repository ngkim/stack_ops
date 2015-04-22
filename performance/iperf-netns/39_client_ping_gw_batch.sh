#!/bin/bash

source "00_check_input_batch.sh"

check_ping() {
  CNT_ERR=0
  CNT_OK=0
  CNT_TOTAL=0
  for TEST_ID in `seq $START $END`; do
    cmd="./31_client_ping_gw.sh"
    run_commands_no_ret $cmd $TEST_ID
    if [ "$?" = 0 ]; then
      echo -e TEST_ID= ${TEST_ID} OK!!!
      CNT_OK=$((CNT_OK + 1))
    else
      echo -e ${red}TEST_ID= ${TEST_ID} ERROR!!!${normal}
      CNT_ERR=$((CNT_ERR + 1))
    fi
    CNT_TOTAL=$((CNT_TOTAL + 1))
  done

  echo "TOTAL= $CNT_TOTAL OK= $CNT_OK ERROR= $CNT_ERR"  
}

for iter in `seq 1 2`; do
  check_ping
done


