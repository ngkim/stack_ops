#!/bin/bash

source "00_check_input.sh"

cmd="cd $IPERF_HOME; ./54_stop_iperf_server_tcp_bidirection_batch.sh $START $END"
run_commands_no_ret $cmd

