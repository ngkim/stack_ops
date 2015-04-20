#!/bin/bash

source "00_check_input.sh"

ping_mgmt() {
  QDHCP=$1

  cmd="ip netns exec $QDHCP ping $IP_MGMT -c 3"
  run_commands $cmd
}

ping_mgmt $2
