#!/bin/bash

if [ -z $1 ]; then
  echo "Usage: $0 [DEV]"
  echo "   ex) $0 eth1"
  exit
fi

run_tcpdump() {
DEV=$1
COUNT=$2
if [ -z $2 ]; then
  COUNT=10
fi

tcpdump -i $DEV -ne -l -c $COUNT 2> /dev/null | awk '{
  if ( $7 == "(0x0800)," ) {
    printf("%s %s %s %s > %s %s %s %s\n", $5, $6, $7, $10, $12, $13, $14, $15)
  } else if ( $7 == "(0x0806)," ) {
    printf("%s %s %s %s > %s %s %s %s\n", $5, $6, $7, $10, $11, $12, $13, $14)
  } else {
    print $0
  }
}'
echo ""
}

DEV=$1
while true; do
  run_tcpdump $DEV 10
done

