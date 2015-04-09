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
create_provider_net 	$NET_GRN $PHYSNET_LAN 	$VLAN_GRN
create_provider_subnet 	$NET_GRN $SBNET_GRN 	$CIDR_GRN

echo "======== PROVIDER NET: ORANGE ========"
create_provider_net 	$NET_ORG $PHYSNET_LAN 	$VLAN_ORG
create_provider_subnet 	$NET_ORG $SBNET_ORG 	$CIDR_ORG

echo "======== PROVIDER NET: RED ========"
create_provider_net 	$NET_RED $PHYSNET_WAN 	$VLAN_RED
create_provider_subnet 	$NET_RED $SBNET_RED 	$CIDR_RED
