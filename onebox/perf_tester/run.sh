#!/bin/bash

source "00_check_input.sh"

./01_start_test.sh $START $END $TEST_ID
sleep 3

print_msg "start vms..."
./03_start_vm.sh $START $END $TEST_ID &> $LOG_VM_CREATE
sleep 3

./check_ping.sh $START $END $TEST_ID
sleep 3

./start_iperf.sh $START $END $TEST_ID

sleep $TIME_WAIT_IPERF

./21_check_iperf_client.sh $START $END $TEST_ID

print_msg "stop vms..."
./13_stop_vm.sh $START $END $TEST_ID &> $LOG_VM_DELETE

./11_stop_test.sh $START $END $TEST_ID

./99_show_result.sh $START $END $TEST_ID
