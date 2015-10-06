#!/bin/bash

source "10_common.sh"

base=0
#LIST="10 20 30 40 50"
#LIST="30 40 50"
LIST="1 3 5 10"
for i in `echo $LIST`; do
  end=$(( $base + $i - 1 ))
  for j in `seq 1 3`; do
    print_msg_high "./run.sh $base $end $j"
    eval "time ./run.sh $base $end $j" 
  done
done
