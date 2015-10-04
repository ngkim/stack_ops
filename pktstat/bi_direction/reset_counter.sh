#!/bin/bash

DRIVER=ixgbe

reset() {
  DEV=$1

  if [ ! -z $DEV ]; then
    echo "ifconfig $DEV 0"
    ifconfig $DEV 0
    echo "ifconfig $DEV down"
    ifconfig $DEV down
    echo "modprobe -r $DRIVER"
    modprobe -r $DRIVER; 
    echo "modprobe $DRIVER"
    modprobe $DRIVER; 
    sleep 3
    echo "ifconfig $DEV up"
    ifconfig $DEV up
  fi
}

reset p2p1
reset p2p2
