#!/bin/bash

source "../include/00_bridge_linux.sh"
source "../include/00_bridge_ovs.sh"
source "../include/01_ip_veth.sh"

DEV_LIST="5ba717fa-58 88a6854b-41 2257fe61-60 7c7b9bef-da d7f01fd0-59 02c649c9-9e c4376de4-34 cd5b55f6-c5 3f12417d-21 65a4d25a-13 4d5759a6-23 e1dc3a76-66 30bae0e5-39 c1eb0851-ad 7270b2ca-4e"

OVS="br-int"
for d in $DEV_LIST; do
  echo $d
  B_DEV="qvb${d}"
  O_DEV="qvo${d}"
  R_DEV="qbr${d}"
  
  create_veth $B_DEV $O_DEV
  add_interface 
done

