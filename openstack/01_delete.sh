#!/bin/bash

source "../include/command_util.sh"

NAME="global"
SBNET_LIST=`neutron subnet-list | grep $NAME | awk '{print $2}' `
NET_LIST=`neutron net-list | grep $NAME | awk '{print $2}' `

for s in $SBNET_LIST; do
  echo $s
  cmd="neutron port-list | grep $s | grep -v '172.16.0.3\"' | grep -v '172.16.0.1\"' | awk '{print \$2}'"
  run_commands $cmd
  PORT_LIST=$RET
  for p in $PORT_LIST; do
    echo $p
    
    cmd="neutron port-delete $p"
    run_commands $cmd
  done
#  cmd="neutron subnet-delete $s"
#  run_commands $cmd
done

#for n in $NET_LIST; do
#  cmd="neutron net-delete $n"
#  run_commands $cmd
#done
