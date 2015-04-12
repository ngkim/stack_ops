#!/bin/bash

source "00_check_input.sh"

./05_create_provider_net.sh $TEST_ID
./06_nova_boot_multinic.sh $TEST_ID
