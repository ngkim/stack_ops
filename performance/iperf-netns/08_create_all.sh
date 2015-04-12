#!/bin/bash

source "00_check_input.sh"

./01_create_bridges_client.sh $TEST_ID
./01_create_bridges_server.sh $TEST_ID
./02_create_clients.sh $TEST_ID
./03_create_server.sh $TEST_ID
