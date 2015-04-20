#!/bin/bash

source "00_check_input_batch.sh"

QDHCP="qdhcp-d7b5ec48-79db-429e-a800-ea4f8d71386b"
IP_PREFIX="172.16.0"

for iter in `seq 58 107`; do
  cmd="ip netns exec $QDHCP ping ${IP_PREFIX}.${iter} -c 3"
  run_commands_no_ret $cmd
  echo "RESULT= $?"
done
