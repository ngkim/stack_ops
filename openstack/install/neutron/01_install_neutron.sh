#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/00_bridge_ovs.sh"
source "$WORK_HOME/include/06_mysql.sh"
source "$WORK_HOME/include/10_packages.sh"
source "$WORK_HOME/include/11_services.sh"
source "$WORK_HOME/include/21_array.sh"

source "neutron.pkg"

iterate_array_cmd _PKG[@] "apt_install_pkg" "\$val"

exec_mysql_query_admin "CREATE DATABASE ${DB};" 
exec_mysql_query_admin "GRANT ALL PRIVILEGES ON ${DB}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
exec_mysql_query_admin "GRANT ALL PRIVILEGES ON ${DB}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"

cmd="create_bridge br-int"
run_commands $cmd

iterate_array_cmd _DIR_CFG[@] "cp" "-r \$_DIR_BAK \$val"
iterate_array_cmd _SVC[@] "svc_start" "\$val"



