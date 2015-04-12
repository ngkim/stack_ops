#!/bin/bash

source "00_check_input_batch.sh"

cmd="./52_stop_iperf_server_tcp_bidirection.sh"
run_batch $cmd
