#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/03_ip_netns.sh"

iperf_tcp_client_netns $ORG_NS $RED_ADDR_ "-t 30"
