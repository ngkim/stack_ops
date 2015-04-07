#!/bin/bash

source "$HOME/bin/include/command_util.sh"

cmd="curl -X POST -d '{
	\"failover_ip\":\"10.0.0.100\"
}' -k https://10.0.0.61/failover/status_utm_failover/"

call_restapi_json $cmd

cmd="ssh cloud-server ethtool p1p1 | grep \"p1p1\|Link detected\""
run_commands $cmd

cmd="ssh cloud-server ethtool p1p2 | grep \"p1p2\|Link detected\""
run_commands $cmd
