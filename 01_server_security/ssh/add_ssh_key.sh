#!/bin/bash

SSH_PUB_KEY=""

HOSTS="orchestrator public customer server-farm cloud-server sdn01 sdn02 arom01 arom02 arom03 10.0.0.201"

for HOST in $HOSTS; do
	echo "ssh $HOST \"echo $SSH_PUB_KEY >> .ssh/authorized_keys\""
	ssh $HOST "echo $SSH_PUB_KEY >> .ssh/authorized_keys"
done

