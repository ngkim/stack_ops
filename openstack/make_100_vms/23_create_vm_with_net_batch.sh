#!/bin/bash

source "00_check_input_batch.sh"

create_vm() {
  for TEST_ID in `seq $START $END`; do
    ./05_create_provider_net.sh $TEST_ID
    ./06_nova_boot_multinic.sh $TEST_ID
    sleep 1
  done
}

create_vm
