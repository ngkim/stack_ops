#!/bin/bash

source "00_check_input.sh"
source "../include/00_bridge_ovs.sh"

for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
  DEV=${ITF[$i]}

  delete_interface $BR_NAME $DEV
done

delete_bridge $BR_NAME
list_bridges
