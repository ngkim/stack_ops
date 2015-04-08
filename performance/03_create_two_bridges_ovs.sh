#!/bin/bash

source "00_check_input.sh"
source "../include/00_bridge_ovs.sh"
source "../include/01_ip_veth.sh"

L_DEV=`echo $VETH | awk '{print $1}'`
R_DEV=`echo $VETH | awk '{print $2}'`
create_veth $L_DEV $R_DEV

setup_bridge $BR1_NAME BR1_ITF[@]
setup_bridge $BR2_NAME BR2_ITF[@]
