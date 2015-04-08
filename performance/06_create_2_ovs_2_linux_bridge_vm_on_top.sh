#!/bin/bash

source "00_check_input.sh"
source "../include/01_ip_veth.sh"
source "../include/00_bridge_linux.sh"

for (( i = 0 ; i < ${#VM_ITF[@]} ; i++ )) do
  itf=${VM_ITF[$i]}
  TAP=`echo $itf | awk '{print $1}'`
  QBR=`echo $itf | awk '{print $2}'`

  delete_interface $QBR $TAP
done

for (( i = 0 ; i < ${#VETH[@]} ; i++ )) do
  veth=${VETH[$i]}
  L_DEV=`echo $veth | awk '{print $1}'`
  R_DEV=`echo $veth | awk '{print $2}'`

  create_veth $L_DEV $R_DEV
done

source "../include/00_bridge_ovs.sh"

setup_bridge $BR1_NAME BR1_ITF[@]
setup_bridge $BR2_NAME BR2_ITF[@]

source "../include/00_bridge_linux.sh"

setup_bridge $BR3_NAME BR3_ITF[@]
setup_bridge $BR4_NAME BR4_ITF[@]
