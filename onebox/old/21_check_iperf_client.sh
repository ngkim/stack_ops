#!/bin/bash

source "00_check_input.sh"

while true; do
  CNT=`ps ax | grep -v grep | grep "iperf -c" | wc -l`
  
  if [ $CNT -eq 0 ]; then
    print_msg_high "Test Done!!!"
    ./stop_iperf.sh $START $END $TEST_ID
    break
  else
    print_msg "Test is still working!!! Wait for $TIME_WAIT_IPERF seconds..."
    sleep $TIME_WAIT_IPERF
  fi
done
