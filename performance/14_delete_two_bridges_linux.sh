#!/bin/bash

source "00_check_input.sh"
source "../include/00_bridge_linux.sh"
source "../include/01_ip_veth.sh"

destroy_bridge $BR1_NAME BR1_ITF[@]
destroy_bridge $BR2_NAME BR2_ITF[@]

L_DEV=`echo $VETH | awk '{print $1}'`
R_DEV=`echo $VETH | awk '{print $2}'`
delete_veth $L_DEV $R_DEV


