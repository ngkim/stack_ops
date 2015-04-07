#!/bin/bash

HOSTS="orchestrator public customer server-farm cloud-server sdn01 sdn02 arom01 arom02 arom03 10.0.0.201"
HOSTS="public customer server-farm cloud-server sdn01 sdn02 arom01 arom02 arom03 10.0.0.201"

for HOST in $HOSTS; do
	echo "scp /etc/hosts.allow $HOST:/etc/"
	scp /etc/hosts.allow $HOST:/etc/
	echo "scp /etc/hosts.deny $HOST:/etc/"
	scp /etc/hosts.deny $HOST:/etc/
done

