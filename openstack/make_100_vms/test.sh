#!/bin/bash

SBNET_ID=`neutron subnet-list | grep 3683ccbd-1ec9-457e-88f0-7f34af6f19a4 | awk '{print $2}'`
#SBNET_ID="3683ccbd-1ec9-457e-88f0-7f34af6f19a4"
if [ ! -z ${SBNET_ID} ]; then
  echo "123"
fi
