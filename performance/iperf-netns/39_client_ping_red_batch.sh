#!/bin/bash

source "00_check_input_batch.sh"

for iter in `seq 1 2`; do
  cmd="./36_client_ping_red.sh"
  run_batch $cmd
done
