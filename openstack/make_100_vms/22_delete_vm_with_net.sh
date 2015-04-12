#!/bin/bash

source "00_check_input.sh"

./16_nova_delete_multinic.sh $TEST_ID
./15_delete_provider_net.sh $TEST_ID
