#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/03_ip_netns.sh"

tcpdump_netns $ORG_NS $ORG_vINT 
