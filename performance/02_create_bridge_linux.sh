#!/bin/bash

source "00_check_input.sh"

cmd="brctl addbr $BR_NAME"
run_commands $cmd

for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        DEV=${ITF[$i]}

        cmd="brctl addif $BR_NAME $DEV"
        run_commands $cmd
done

cmd="ifconfig $BR_NAME up"
run_commands $cmd
