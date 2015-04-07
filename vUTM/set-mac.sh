#!/bin/bash -x

ifconfig br0 hw ether 44:8A:5B:3A:19:0F
ip link set dev br0 promisc on

ifconfig br1 hw ether 44:8A:5B:3A:1A:0F 
ip link set dev br1 promisc on

ifconfig br2 hw ether 44:8A:5B:3A:1C:0F
ip link set dev br2 promisc on

ip addr show br0
ip addr show br1
ip addr show br2
