#!/bin/bash

source "00_check_input_global.sh"

ssh-keygen -t rsa -f spirent
run_commands "nova keypair-delete spirent"
run_commands "nova keypair-add --pub_key spirent.pub spirent"
run_commands "nova keypair-show spirent"
