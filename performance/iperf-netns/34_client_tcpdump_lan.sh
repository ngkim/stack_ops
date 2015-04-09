#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/04_tcpdump.sh"

run_tcpdump $ITF_LAN
