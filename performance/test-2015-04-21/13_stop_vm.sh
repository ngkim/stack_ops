#!/bin/bash

source "00_check_input.sh"

cmd="$cmd_ssh \"cd ~/bin/openstack/make_100_vms; ./24_delete_vm_with_net_batch.sh $START $END\""
run_commands_no_ret $cmd

LOC="~/bin/openstack/make_100_vms"
SCRIPT="24_delete_vm_with_net_batch.sh"

run_remote_cmd $LOC $SCRIPT


