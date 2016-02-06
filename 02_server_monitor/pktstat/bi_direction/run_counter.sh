#!/bin/bash

LOG=$1

if [ ! -z $LOG ]; then
  ./show_counter.sh vUTM-0.cfg &> $LOG &
  echo $! > .pid
fi
