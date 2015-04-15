#!/bin/bash

source "00_check_input.sh"

for process in $(ls /etc/init/neutron* | cut -d'/' -f4 | cut -d'.' -f1)
do
    echo -e ${green}${process}${normal}
    sudo stop ${process}
    sudo start ${process}
done
service openvswitch-switch restart
service dnsmasq restart

