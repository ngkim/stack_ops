#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_linux.sh"
source "$WORK_HOME/include/01_ip_veth.sh"
source "$WORK_HOME/include/03_ip_netns.sh"

delete_client() {
  local NS_NAME=$1
  local vINT=$2
  local vEXT=$3
  local BR_NAME=$4
  local IP_ADDR=$5
  local GW_ADDR=$6

  ip_route_del_default_netns $NS_NAME
  ifconfig_netns $NS_NAME $vINT 0

  delete_interface $BR_NAME $vEXT
  delete_veth $vEXT $vINT

  remove_netns $NS_NAME
}

delete_client $GRN_NS \
                $GRN_vINT $GRN_vEXT \
                $BR_GRN \
                $GRN_ADDR $GRN_GATE

delete_client $ORG_NS \
                $ORG_vINT $ORG_vEXT \
                $BR_ORG \
                $ORG_ADDR $ORG_GATE

