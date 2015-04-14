#!/bin/bash

source "00_check_input.sh"

run_mysqldump() {
  local DB=$1
  local USER=$2
  local PASS=$3
  local DUMP=$4

  cmd="mysqldump -u $USER -p$PASS $DB > $DUMP"
  run_commands $cmd
}

NOW=`date +%y%m%d-%H%M`
DUMP_DIR="dump/$NOW"
mkdir -p $DUMP_DIR

run_mysqldump nova nova nova $DUMP_DIR/nova.dump
run_mysqldump neutron neutron neutron $DUMP_DIR/neutron.dump
