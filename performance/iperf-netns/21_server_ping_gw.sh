#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_linux.sh"
source "$WORK_HOME/include/01_ip_veth.sh"
source "$WORK_HOME/include/03_ip_netns.sh"

ping_netns $RED_NS $RED_GATE
