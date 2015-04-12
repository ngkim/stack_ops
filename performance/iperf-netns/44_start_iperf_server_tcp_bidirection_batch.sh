#!/bin/bash

source "00_check_input_batch.sh"

cmd="./42_start_iperf_server_tcp_bidirection.sh"
run_batch $cmd
