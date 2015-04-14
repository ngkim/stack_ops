#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/provider_net_util.sh"

cmd="glance image-list | awk '/'$VM_IMAGE'/{print \$2}'"
run_commands $cmd
IMAGE_ID=$RET

cmd="neutron net-list | awk '/'$NET_MGMT'/{print \$2}'"
run_commands $cmd
NET_MGMT_ID=$RET

cmd="neutron net-list | awk '/'$NET_RED'/{print \$2}'"
run_commands $cmd
NET_RED_ID=$RET

cmd="neutron net-list | grep '$NET_GRN ' | awk '/'$NET_GRN'/{print \$2}'"
run_commands $cmd
NET_GRN_ID=$RET

cmd="neutron net-list | grep '$NET_ORG ' | awk '/'$NET_ORG'/{print \$2}'"
run_commands $cmd
NET_ORG_ID=$RET

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
