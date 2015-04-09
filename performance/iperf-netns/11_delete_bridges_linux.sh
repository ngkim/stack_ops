#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_linux.sh"
source "$WORK_HOME/include/02_vconfig.sh"

destroy_bridge $BR_GRN BR_GRN_ITF[@]
destroy_bridge $BR_ORG BR_ORG_ITF[@]
destroy_bridge $BR_RED BR_RED_ITF[@]

remove_vlan_interface $ITF_LAN $VLAN_GRN
remove_vlan_interface $ITF_LAN $VLAN_ORG
