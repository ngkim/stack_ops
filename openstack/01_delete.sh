#!/bin/bash

source "../include/command_util.sh"

NAME="global"
SBNET_LIST=`neutron subnet-list | grep $NAME | awk '{print $2}' `
NET_LIST=`neutron net-list | grep $NAME | awk '{print $2}' `

for s in $SBNET_LIST; do
  echo $s
  PORT_LIST=`neutron port-list | grep $s | awk '{print $2}'`
  for p in $PORT_LIST; do
    echo $p
    cmd="neutron port-delete $p"
    run_commands $cmd
  done
  cmd="neutron subnet-delete $s"
  run_commands $cmd
done

for n in $NET_LIST; do
  cmd="neutron net-delete $n"
  run_commands $cmd
done
