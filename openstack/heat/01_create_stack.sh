#!/bin/bash

usage() {
  echo "Usage: $0 [STACK_NAME]"
  echo "   ex) $0 mystack"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

STACK_NAME=$1

heat stack-create -f yaml/hot_eutm-waf_v2.yaml -P "PARM_imageId_eutm=00c1a19e-77a6-4309-aa87-2efc1c4d9118;PARM_mgmtVnetId_eutm=9f6ea02a-e9b8-406d-bf9d-9c266218ed3e;PARM_redVnetId_eutm=4dc2ddd6-1bc5-42d5-a89f-8bc0db426b34;PARM_redFixedIp_eutm=211.224.204.216;PARM_greenVnetId_eutm=e80a95e1-8852-44cd-9df2-6b8ea9ddf3b8;PARM_greenFixedIp_eutm=192.168.0.252;PARM_orangeVnetId_eutm=59b777d2-7407-4dbd-95f7-a4f129f212c1;PARM_orangeFixedIp_eutm=192.168.1.252;PARM_imageId_waf=55eea66d-645c-4c0b-9421-3a4ffb38d659;PARM_mgmtVnetId_waf=9f6ea02a-e9b8-406d-bf9d-9c266218ed3e;PARM_svcVnetId_waf=59b777d2-7407-4dbd-95f7-a4f129f212c1;PARM_svcFixedIp_waf=192.168.1.14" $STACK_NAME

