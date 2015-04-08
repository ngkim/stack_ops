#!/bin/bash

source "00_check_input.sh"
source "../include/00_bridge_ovs.sh"

setup_bridge $BR_NAME ITF[@]
