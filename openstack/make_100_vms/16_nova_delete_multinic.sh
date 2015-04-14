#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/nova_util.sh"

delete_vm $VM_NAME
