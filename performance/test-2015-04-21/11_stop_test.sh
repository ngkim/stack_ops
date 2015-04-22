#!/bin/bash

source "00_check_input.sh"

cmd="$cmd_ssh \"cd bin/pktstat; ./stop_counter.sh\""
run_commands_no_ret $cmd

cmd="${cmd_scp}:bin/pktstat/${C_LOG} $DIR_LOG_CNT"
run_commands_no_ret $cmd
