#!/bin/bash

if [ -z $2 ]; then
  echo "Usage: $0 [START] [END]"
  echo "   ex) $0 3 5"
  exit
fi

START=$1
END=$2

for TEST_ID in `seq $START $END`; do
  ./08_create_all.sh $TEST_ID
done
