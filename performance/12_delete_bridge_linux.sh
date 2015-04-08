#!/bin/bash

source "00_check_input.sh"

cmd="ifconfig $BR_NAME down"
run_commands $cmd

for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        DEV=${ITF[$i]}

        cmd="brctl delif $BR_NAME $DEV"
        run_commands $cmd
done

cmd="brctl delbr $BR_NAME"
run_commands $cmd


