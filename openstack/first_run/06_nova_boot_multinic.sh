#!/bin/bash

source '../include/command_util.sh'

if [ -z $1 ]; then
  echo "Usage: $0 [config_file]"
  echo "   ex: $0 provider-net.ini"
  exit
fi

CONFIG=$1

if [ ! -f $CONFIG ]; then
  echo "Error: $CONFIG does not exist!!!"
  exit
else
  source "$CONFIG"
fi

# TODO: Tenant ID 옵션 지원
if [ -z ${OS_AUTH_URL+x} ]; then
    source ~/openstack_rc
fi

echo "glance image-list | awk '/'$VM_IMAGE'/{print $2}'"
IMAGE_ID=`glance image-list | awk '/'$VM_IMAGE'/{print $2}'`
echo "neutron net-list | awk '/'$NET_MGMT'/{print $2}'"
NET_MGMT_ID=`neutron net-list | awk '/'$NET_MGMT'/{print $2}'`
NET_MGMT_ID=`neutron net-list | awk '/'$NET_MGMT'/{print $2}'`
NET_RED_ID=`neutron net-list | awk '/'$NET_RED'/{print $2}'`
NET_GRN_ID=`neutron net-list | awk '/'$NET_GRN'/{print $2}'`
NET_ORG_ID=`neutron net-list | awk '/'$NET_ORG'/{print $2}'`

source "bootstrap/provider_bootstrap_template.sh" \
	"dat/provider-$VM_NAME.dat" \
	$NIC_GRN \
	$IP_GRN \
	$NIC_ORG \
	$IP_ORG \
        $NIC_RED \
        $IP_RED \
        $GW_RED

do_nova_boot() {
	# TODO: 입력값의 오류 확인, empty string일 경우 return
	
    cmd="nova boot $VM_NAME \
        --flavor $VM_FLAVOR_UTM \
        --image $IMAGE_ID \
        --key-name $ACCESS_KEY \
	--nic net-id=$NET_MGMT_ID \
        --nic net-id=$NET_RED_ID \
	--nic net-id=$NET_GRN_ID \
	--nic net-id=$NET_ORG_ID \
        --availability-zone $AV_ZONE \
        --security-groups default \
        --user-data dat/provider-$VM_NAME.dat"
    
    run_commands $cmd
}

do_nova_boot
