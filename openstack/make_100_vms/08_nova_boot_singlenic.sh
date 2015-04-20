#!/bin/bash

source "00_check_input.sh"
source "$WORK_HOME/include/provider_net_util.sh"

cmd="glance image-list | awk '/'$VM_IMAGE'/{print \$2}'"
run_commands $cmd
IMAGE_ID=$RET

cmd="neutron net-list | awk '/'$NET_MGMT'/{print \$2}'"
run_commands $cmd
NET_MGMT_ID=$RET

cmd="neutron subnet-list | awk '/'$SBNET_MGMT'/{print \$2}'"
run_commands $cmd
SBNET_MGMT_ID=$RET

source "bootstrap/provider_bootstrap_template_singlenic.sh" \
	"dat/provider-$VM_NAME.dat"

do_nova_boot() {
	# TODO: 입력값의 오류 확인, empty string일 경우 return
	
    cmd="nova boot $VM_NAME \
        --flavor $VM_FLAVOR_UTM \
        --image $IMAGE_ID \
        --key-name $ACCESS_KEY \
	--nic net-id=$NET_MGMT_ID \
        --availability-zone $AV_ZONE \
        --security-groups default \
        --user-data dat/provider-$VM_NAME.dat"
    
    run_commands $cmd
    sleep 0.5
}

do_nova_boot
