#!/bin/bash

run_command() {
  local CMD=$*
  
  echo $CMD
  eval $CMD
}

#----------------------------------------------------------
# NGKIM: 2015-10-20
# use first argument as iptables script file name
#----------------------------------------------------------
if [ -z $1 ]; then
  IPTBL_FILENAME="iptables.up.rules"
else
  IPTBL_FILENAME=$1
fi

BAK_DIR="00-iptables.up.rules/${HOSTNAME}"
BAK_DATE=`date +%y%m%d-%H%M`

#----------------------------------------------------------
# step 1. backup /etc/iptables.up.rules
#----------------------------------------------------------
mkdir -p $BAK_DIR
if [ -f /etc/sysconfig/iptables ]; then
  cmd="cp /etc/sysconfig/iptables $BAK_DIR/iptables-${BAK_DATE}"
  run_command $cmd
fi

#----------------------------------------------------------
# step 2. copy iptables script to /etc
#----------------------------------------------------------
cmd="cp ${IPTBL_FILENAME} /etc/sysconfig/iptables"
run_command $cmd

#----------------------------------------------------------
# step 3. run iptables-restore
#----------------------------------------------------------
cmd="iptables-restore < /etc/sysconfig/iptables"
run_command $cmd

#----------------------------------------------------------
# step 4. save to /etc/sysconfig/iptables
#----------------------------------------------------------
cmd="/sbin/service iptables save"
run_command $cmd
