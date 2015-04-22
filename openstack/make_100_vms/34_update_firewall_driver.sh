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

update_neutron_ml2_fw_driver() {
  param=$1
  value=$2

  cmd="crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup $param $value"
  run_commands $cmd
}

restart_service() {
  svc=$1

  cmd="service $svc restart"
  run_commands $cmd
}

check_cmd crudini

#update_neutron_ml2_fw_driver firewall_driver neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
update_neutron_ml2_fw_driver firewall_driver neutron.agent.firewall.NoopFirewallDriver

restart_service nova-api
restart_service nova-compute
restart_service nova-scheduler

restart_service neutron-plugin-openvswitch-agent
restart_service neutron-server
