#!/bin/bash

source "../include/command_util.sh"
source "../include/provider_net_util.sh"

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

echo "======== PROVIDER NET: GREEN ========"
delete_provider_subnet 	$SBNET_GRN
delete_provider_net 	$NET_GRN

echo "======== PROVIDER NET: ORANGE ========"
delete_provider_subnet 	$SBNET_ORG
delete_provider_net 	$NET_ORG

echo "======== PROVIDER NET: RED ========"
delete_provider_subnet 	$SBNET_RED
delete_provider_net 	$NET_RED
