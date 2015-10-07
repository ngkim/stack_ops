#!/bin/bash

source "00_check_input.sh"

#----------------------------------------------------------------------------------------------

usage() {
  echo "Usage: $0 [CONFIG]"
  echo "   ex) $0 config/onebox03.cfg"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

#----------------------------------------------------------------------------------------------
CONFIG=$1
source $CONFIG
#----------------------------------------------------------------------------------------------

for node in "${NODE_LIST[@]}"; do
  node_name=`echo $node | awk '{print $1}'`

  print_msg "${node_name}: copy dumps" 
  ./10_copy_dumps.sh ${node_name} $REC_DIR
done

if [ ! -z $UTM ]; then
  print_msg "${node_name}: copy dumps" 
  ./10_copy_dumps.sh ${UTM} $REC_DIR
fi

cp $CONFIG ${REC_DIR}
