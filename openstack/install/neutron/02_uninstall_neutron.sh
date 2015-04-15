#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_ovs.sh"
source "$WORK_HOME/include/06_mysql.sh"
source "$WORK_HOME/include/10_packages.sh"
source "$WORK_HOME/include/11_services.sh"
source "$WORK_HOME/include/21_array.sh"

source "neutron.pkg"

iterate_array_cmd _PROC[@] "killall" "\$val"
iterate_array_cmd _SVC[@] "svc_stop" "\$val"

cmd="clear_bridge br-int"
run_commands $cmd

iterate_array_cmd _PKG[@] "apt_uninstall_pkg" "\$val"
cmd="apt-get -y autoremove"
run_commands $cmd

cmd="mkdir -p $_DIR_BAK"
run_commands $cmd

iterate_array_cmd _DIR_CFG[@] "cp" "-r \$val \$_DIR_BAK"

exec_mysql_query_admin "DROP DATABASE ${DB};" 
