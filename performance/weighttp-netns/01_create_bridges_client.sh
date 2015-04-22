#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_linux.sh"
source "$WORK_HOME/include/02_vconfig.sh"

create_vlan_interface $ITF_LAN $VLAN_GRN
create_vlan_interface $ITF_LAN $VLAN_ORG

setup_bridge $BR_GRN BR_GRN_ITF[@]
setup_bridge $BR_ORG BR_ORG_ITF[@]
