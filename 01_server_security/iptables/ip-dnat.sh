#!/bin/bash

NAT_IP=211.224.204.172
DST_IP=10.0.0.70

#ip addr add $NAT_IP/25 dev em2

echo "iptables -t nat -A PREROUTING -d $NAT_IP -j DNAT --to-destination $DST_IP"
iptables -t nat -A PREROUTING -d $NAT_IP -j DNAT --to-destination $DST_IP

echo ""
iptables -t nat -L -n
