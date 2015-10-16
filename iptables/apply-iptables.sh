#!/bin/bash

run_command() {
  local CMD=$*
  
  echo $CMD
  eval $CMD
}

BAK_DIR="00-iptables.up.rules/${HOSTNAME}"
BAK_DATE=`date +%y%m%d-%H%M`

mkdir -p $BAK_DIR
if [ -f /etc/iptables.up.rules ]; then
  cmd="cp /etc/iptables.up.rules $BAK_DIR/iptables.up.rules-${BAK_DATE}"
  run_command $cmd
fi

cmd="cp iptables.up.rules /etc"
run_command $cmd

cmd="iptables-restore < /etc/iptables.up.rules"
run_command $cmd
