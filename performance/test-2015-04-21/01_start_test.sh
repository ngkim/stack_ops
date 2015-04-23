#!/bin/bash

source "00_check_input.sh"

cmd="$cmd_ssh_no_color \"cd bin/pktstat; ./run_counter.sh $LOG_REMOTE_COUNTER\""
run_commands_no_ret $cmd
