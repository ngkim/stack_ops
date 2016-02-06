#!/bin/bash

HOST_LIST[0]="211.224.204.201 client"
HOST_LIST[1]="211.224.204.202 mserver"
HOST_LIST[2]="211.224.204.203 orch"
HOST_LIST[3]="211.224.204.204 test-server"
HOST_LIST[4]="211.224.204.205 onebox01"
HOST_LIST[5]="211.224.204.206 onebox02"
HOST_LIST[6]="211.224.204.207 onebox03"
HOST_LIST[7]="211.224.204.208 mserver2"
HOST_LIST[8]="211.224.204.209 dev01"
HOST_LIST[9]="211.224.204.157 onebox04"
HOST_LIST[10]="211.224.204.147 kilo" 

for (( i = 0 ; i < ${#HOST_LIST[@]} ; i++ )) do
  _IP=${HOST_LIST[$i]}
  IP=`echo $_IP | awk '{print $1}'`
  echo "================== IP= $IP"
  scp ifconfig.d/iptablesload $IP:/etc/network/if-pre-up.d 
  scp ifconfig.d/iptablessave $IP:/etc/network/if-post-down.d 
  ssh $IP "/etc/network/if-pre-up.d/iptablesload"
  ssh $IP "iptables -L -n"
  sleep 1
  clear
done



