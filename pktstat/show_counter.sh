#!/bin/bash

get_pkt_counter() {
	DEV=$1
	MODE=$2
        
        if [ ! -z $DEV ]; then
        	STR=`/sbin/ifconfig $DEV | /bin/grep "$MODE packets" | /usr/bin/awk '{print $2}'`
		printf "%s" $STR
        fi
}

get_drop_counter() {
	local DEV=$1
	local MODE=$2
        
        if [ ! -z $DEV ]; then
        	STR=`/sbin/ifconfig $DEV | /bin/grep "$MODE packets" | /usr/bin/awk '{print $4}'`
		printf "%s" $STR
        fi
}

show_counter() {
	local DEV=$1

        echo "DEV= $DEV"
	if [ ! -z $DEV ]; then
		TX_PKT=`get_pkt_counter $DEV "TX"`
		TX_DROP=`get_drop_counter $DEV "TX"`
		RX_PKT=`get_pkt_counter $DEV "RX"`
		RX_DROP=`get_drop_counter $DEV "RX"`

                printf "\t%s %-20s %-20s\n" "TX" $TX_PKT $TX_DROP
                printf "\t%s %-20s %-20s\n" "RX" $RX_PKT $RX_DROP
	fi
}

DEV_IN="fb308d2a-7a"
DEV_OUT="7f08463f-0a"

PATH[0]="p2p1"
PATH[1]="phy-br-lan"
PATH[2]="int-br-lan"
PATH[3]="qvo${DEV_IN}"
PATH[4]="qvb${DEV_IN}"
PATH[5]="tap${DEV_IN}"
PATH[6]="tap${DEV_OUT}"
PATH[7]="qvb${DEV_OUT}"
PATH[8]="qvo${DEV_OUT}"
PATH[9]="int-br-wan"
PATH[10]="phy-br-wan"
PATH[11]="p2p2"

for (( i = 0 ; i < ${#PATH[@]} ; i++ )) do
        DEV=${PATH[$i]}
	show_counter $DEV
done
