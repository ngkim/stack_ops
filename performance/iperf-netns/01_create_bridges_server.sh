#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_linux.sh"

setup_bridge $BR_RED BR_RED_ITF[@]
