#!/bin/bash

source "00_check_input.sh"

cmd="$cmd_ssh \"cd bin/pktstat; ./run_counter.sh $C_LOG\""
run_commands $cmd
