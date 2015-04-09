#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_linux.sh"
source "$WORK_HOME/include/01_ip_veth.sh"
source "$WORK_HOME/include/03_ip_netns.sh"

create_client() {
  local NS_NAME=$1
  local vINT=$2
  local vEXT=$3
  local BR_NAME=$4
  local IP_ADDR=$5
  local GW_ADDR=$6

  create_netns $NS_NAME
  create_veth $vINT $vEXT
  set_veth_ns $vINT $NS_NAME
  add_interface $BR_NAME $vEXT
  
  ifconfig_netns $NS_NAME $vINT $IP_ADDR
  ip_route_add_default_netns $NS_NAME $GW_ADDR
  show_route_netns $NS_NAME
}

create_client $GRN_NS \
                $GRN_vINT $GRN_vEXT \
                $BR_GRN \
                $GRN_ADDR $GRN_GATE

create_client $ORG_NS \
                $ORG_vINT $ORG_vEXT \
                $BR_ORG \
                $ORG_ADDR $ORG_GATE

