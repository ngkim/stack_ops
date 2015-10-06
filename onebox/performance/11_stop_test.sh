#!/bin/bash

source "00_check_input.sh"

cmd="$cmd_ssh_no_color \"cd bin/pktstat; ./stop_counter.sh\""
run_commands_no_ret $cmd

cmd="${cmd_scp}:bin/pktstat/${LOG_REMOTE_COUNTER} $DIR_LOG_COUNTER"
run_commands_no_ret $cmd

cmd="$cmd_ssh_no_color \"cd bin/pktstat; ./clear_counter.sh $LOG_REMOTE_COUNTER\""
run_commands_no_ret $cmd
