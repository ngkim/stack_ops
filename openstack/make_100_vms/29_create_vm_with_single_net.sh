#!/bin/bash

source "00_check_input.sh"

./05_create_provider_net.sh $TEST_ID
./08_nova_boot_singlenic.sh $TEST_ID
