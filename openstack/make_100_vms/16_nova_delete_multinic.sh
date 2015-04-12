#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/provider_net_util.sh"

echo "nova list | awk '/'$VM_NAME'/{print \$2}'"
VM_ID=`nova list | awk '/'$VM_NAME'/{print $2}'`

echo "nova delete $VM_ID"
nova delete $VM_ID
