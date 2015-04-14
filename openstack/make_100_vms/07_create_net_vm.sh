#!/bin/bash

if [ -z $2 ]; then
  echo "Usage: $0 [START] [END]"
  echo "   ex) $0 3 5"
  exit
fi

START=$1
END=$2

for TEST_ID in `seq $START $END`; do
  ./05_create_provider_net.sh $TEST_ID
  sleep 0.5
done

sleep 1

for TEST_ID in `seq $START $END`; do
  ./06_nova_boot_multinic.sh $TEST_ID
  sleep 0.5
done


