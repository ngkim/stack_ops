#!/bin/bash

source "00_check_input_global.sh"

update_nova_quotas() {
  project_id=$1
  key=$2
  val=$3

  nova-manage project quota --project=$project_id --key=${key} --value=${val}
}

check_cmd() {
  cmd=$1
  eval $cmd 2> /dev/null
  if [ $? -eq 127 ]; then
    apt-get -y install $cmd
  fi
}

update_nova_allocation_ratio() {
  param=$1
  value=$2

  cmd="crudini --set /etc/nova/nova.conf DEFAULT $param $value"
  run_commands $cmd
}

update_neutron_quotas() {
  param=$1
  value=$2

  cmd="crudini --set /etc/neutron/neutron.conf quotas $param $value"
  run_commands $cmd
}

restart_service() {
  svc=$1

  cmd="service $svc restart"
  run_commands $cmd
}

check_cmd crudini

update_nova_allocation_ratio cpu_allocation_ratio 20.0
update_nova_allocation_ratio ram_allocation_ratio 2.5
update_nova_allocation_ratio disk_allocation_ratio 1.5

TENANT=admin
PROJECT_ID=`keystone tenant-list | awk '/'$TENANT'/{print $2}'`

echo "TENANT= $TENANT PROJEC_ID=$PROJECT_ID"
update_nova_quotas $PROJECT_ID instances 200
update_nova_quotas $PROJECT_ID cores 300
update_nova_quotas $PROJECT_ID ram 500000 

restart_service nova-api
restart_service nova-compute

update_neutron_quotas quota_network 400
update_neutron_quotas quota_subnet 400
update_neutron_quotas quota_port 500
update_neutron_quotas quota_router 10
update_neutron_quotas quota_floatingip 100
update_neutron_quotas quota_security_group 1000
update_neutron_quotas quota_security_group_rule 5000

restart_service neutron-server
restart_service neutron-plugin-openvswitch-agent
