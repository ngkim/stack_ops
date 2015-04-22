#!/bin/bash

source "00_check_input_batch.sh"

QDHCP="qdhcp-d7b5ec48-79db-429e-a800-ea4f8d71386b"

create_vm() {
  for TEST_ID in `seq $START $END`; do
    ./05_create_provider_net_grn.sh $TEST_ID
    ./09_nova_boot_twonic_fixed_ip.sh $TEST_ID
    sleep 1
  done
}

get_vm_name() {
  source "config/provider-net.ini"
  echo $VM_NAME
}

check_ping() {
  CNT_ERR=0
  CNT_OK=0
  CNT_TOTAL=0
  for TEST_ID in `seq $START $END`; do
    ./36_ping_mgmt.sh $TEST_ID $QDHCP
    if [ "$?" = 0 ]; then
      echo -e DST= $(get_vm_name) OK!!!
      CNT_OK=$((CNT_OK + 1))
    else
      echo -e ${red}DST= $(get_vm_name) ERROR!!!${normal}
      CNT_ERR=$((CNT_ERR + 1))
    fi
    CNT_TOTAL=$((CNT_TOTAL + 1))
  done
  
  echo "TOTAL= $CNT_TOTAL OK= $CNT_OK ERROR= $CNT_ERR"  
}

#create_vm
check_ping
