#!/bin/bash

if [ -z $1 ]; then
  echo "Usage: $0 [config_file]"
  echo "   ex: $0 provider-net.ini"
  exit
fi

CONFIG=$1

if [ ! -f $CONFIG ]; then
  echo "Error: $CONFIG does not exist!!!"
  exit
else
  source "$CONFIG"
fi

if [ -z ${OS_AUTH_URL+x} ]; then
    source ~/openstack_rc
fi

echo "nova list | awk '/'$VM_NAME'/{print \$2}'"
VM_ID=`nova list | awk '/'$VM_NAME'/{print $2}'`

echo "nova delete $VM_ID"
nova delete $VM_ID
