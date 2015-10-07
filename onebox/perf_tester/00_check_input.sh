#!/bin/bash

WORK_HOME=$HOME/workspace/stack_ops

source "$WORK_HOME/include/command_util.sh"
source "$WORK_HOME/include/05_process.sh"

#--------------------------------------------------------
# REMOTE Directory to store test results
#--------------------------------------------------------
NOW=`date '+%Y%m%d_%H%M%S'`
LOG_DIR="/tmp/perf/$NOW"
LOG_DIR_AB="/tmp/perf/ab/$NOW"
LOG_DIR_IPERF="/tmp/perf/iperf/$NOW"

#--------------------------------------------------------
# LOCAL Directory to store test results
# Set it if it doesn't exist
#--------------------------------------------------------
if [ -z $REC_DIR ]; then
  REC_DIR="/tmp/records/exp-${NOW}"
fi


