#!/bin/bash

source "00_check_input.sh"

LOC="~/bin/openstack/make_100_vms"
SCRIPT="23_create_vm_with_net_batch.sh"

run_remote_cmd $LOC $SCRIPT
