#!/bin/bash

if [ -z $1 ]; then
  echo "Usage: $0 [config_file]"
  echo "   ex: $0 vm.cfg"
  exit
fi

CONFIG=$1

if [ ! -f $CONFIG ]; then
  echo "Error: $CONFIG does not exist!!!"
  exit
else
  source "$CONFIG"
fi

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

get_tx_qlen() {
	local DEV=$1
        
        if [ ! -z $DEV ]; then
        	STR=`/sbin/ifconfig $DEV | /bin/grep "txqueuelen" | /usr/bin/awk '{print $2}'`
		printf "%s" $STR
        fi
}

#### Colors
blue=$(/usr/bin/tput setaf 4)
green=$(/usr/bin/tput setaf 2)
normal=$(/usr/bin/tput sgr0)

show_counter() {
	local SEQ=$1
	local DEV=$2

	if [ ! -z $DEV ]; then
		TX_PKT=`get_pkt_counter $DEV "TX"`
		TX_DROP=`get_drop_counter $DEV "TX"`
		TX_QLEN=`get_tx_qlen $DEV`
		RX_PKT=`get_pkt_counter $DEV "RX"`
		RX_DROP=`get_drop_counter $DEV "RX"`
                printf "%3d %-20s\t%s %-20s %-20s %-20s %s %-20s %-20s\n" $SEQ $DEV ${blue}TX${normal} $TX_PKT $TX_DROP $TX_QLEN ${green}RX${normal} $RX_PKT $RX_DROP
	fi
}

for (( i = 0 ; i < ${#PATH[@]} ; i++ )) do
        DEV=${PATH[$i]}
	show_counter $i $DEV
done
