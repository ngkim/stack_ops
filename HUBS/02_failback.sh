#!/bin/bash

source "$HOME/bin/include/command_util.sh"

#curl -X POST -d '{"failover_ip":"10.0.0.100"}' -k https://10.0.0.61/failover/request_utm_failover/
cmd="curl -X POST -d '{
  \"failback\": {
    \"officecode\": \"R99999\",
    \"axgateip\": \"10.0.0.100\",
    \"failmsg\": \"네트워크 장애\",
    \"userid\": \"10001234\"
  }
}' -k http://10.0.0.71:8888/service/failback"
call_restapi_json $cmd

cmd="ssh cloud-server ifconfig p1p1 down"
run_commands $cmd

cmd="ssh cloud-server ifconfig p1p2 down"
run_commands $cmd
