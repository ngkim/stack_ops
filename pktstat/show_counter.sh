#!/bin/bash

# Log history
# history folder name: history/date '+%Y%m%d%H%M'
# history file name: $DEV.log

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
                STR=`cat /sys/class/net/${DEV}/statistics/${MODE}_packets`
		printf "%s" $STR
        fi
}

get_byte_counter() {
	local DEV=$1
	local MODE=$2
        
        if [ ! -z $DEV ]; then
                STR=`cat /sys/class/net/${DEV}/statistics/${MODE}_bytes`
		printf "%s" $STR
        fi
}



get_drop_counter() {
	local DEV=$1
	local MODE=$2
        
        if [ ! -z $DEV ]; then
                STR=`cat /sys/class/net/${DEV}/statistics/${MODE}_dropped`
		printf "%s" $STR
        fi
}

#### Colors
blue=$(/usr/bin/tput setaf 4)
green=$(/usr/bin/tput setaf 2)
normal=$(/usr/bin/tput sgr0)

#### History
LOGGING_TIME=`date '+%Y%m%d%H%M'`
DIR_HISTORY="history/$LOGGING_TIME"
mkdir -p $DIR_HISTORY

get_counter() {
	local SEQ=$1
	local DEV=$2

        local LOG_TX_PKT="$DIR_HISTORY/${DEV}-tx-pkts.log"
        local LOG_TX_BYTES="$DIR_HISTORY/${DEV}-tx-pkts.log"
        local LOG_RX_PKT="$DIR_HISTORY/${DEV}-rx-pkts.log"
        local LOG_RX_BYTES="$DIR_HISTORY/${DEV}-rx-pkts.log"

	if [ ! -z $DEV ]; then
                PREV_TX_PKT=${ARR_TX_PKT[$SEQ]}
                PREV_RX_PKT=${ARR_RX_PKT[$SEQ]}
                PREV_TX_DROP=${ARR_TX_DROP[$SEQ]}
                PREV_RX_DROP=${ARR_RX_DROP[$SEQ]}
                PREV_TX_BYTES=${ARR_TX_BYTES[$SEQ]}
                PREV_RX_BYTES=${ARR_RX_BYTES[$SEQ]}

                PREV_ARR_TX_PKT[$SEQ]=$PREV_TX_PKT
                PREV_ARR_RX_PKT[$SEQ]=$PREV_RX_PKT
                PREV_ARR_TX_DROP[$SEQ]=$PREV_TX_DROP
                PREV_ARR_RX_DROP[$SEQ]=$PREV_RX_DROP
                PREV_ARR_TX_BYTES[$SEQ]=$PREV_TX_BYTES
                PREV_ARR_RX_BYTES[$SEQ]=$PREV_RX_BYTES

             	CUR_TX_PKT=`get_pkt_counter $DEV "tx"`
		CUR_RX_PKT=`get_pkt_counter $DEV "rx"`
		CUR_TX_DROP=`get_drop_counter $DEV "tx"`
		CUR_RX_DROP=`get_drop_counter $DEV "rx"`
		CUR_TX_BYTES=`get_byte_counter $DEV "tx"`
		CUR_RX_BYTES=`get_byte_counter $DEV "rx"`

#                printf "%s %20s %5s %-100s\n" "echo" $CUR_TX_PKT ">>" $LOG_TX_PKT
                echo $CUR_TX_PKT   >> $LOG_TX_PKT
                echo $CUR_TX_BYTES >> $LOG_TX_BYTES
                echo $CUR_RX_PKT   >> $LOG_RX_PKT
                echo $CUR_RX_BYTES >> $LOG_RX_BYTES

	        ARR_TX_PKT[$SEQ]=$CUR_TX_PKT
                ARR_RX_PKT[$SEQ]=$CUR_RX_PKT
                ARR_TX_DROP[$SEQ]=$CUR_TX_DROP
                ARR_RX_DROP[$SEQ]=$CUR_RX_DROP
                ARR_TX_BYTES[$SEQ]=$CUR_TX_BYTES
                ARR_RX_BYTES[$SEQ]=$CUR_RX_BYTES
	fi
}

show_counter() {
	local SEQ=$1
	local DEV=$2

	if [ ! -z $DEV ]; then
                PREV_TX_PKT=${PREV_ARR_TX_PKT[$SEQ]}
                PREV_RX_PKT=${PREV_ARR_RX_PKT[$SEQ]}
                PREV_TX_DROP=${PREV_ARR_TX_DROP[$SEQ]}
                PREV_RX_DROP=${PREV_ARR_RX_DROP[$SEQ]}
                PREV_TX_BYTES=${PREV_ARR_TX_BYTES[$SEQ]}
                PREV_RX_BYTES=${PREV_ARR_RX_BYTES[$SEQ]}

                CUR_TX_PKT=${ARR_TX_PKT[$SEQ]}
                CUR_RX_PKT=${ARR_RX_PKT[$SEQ]}
                CUR_TX_DROP=${ARR_TX_DROP[$SEQ]}
                CUR_RX_DROP=${ARR_RX_DROP[$SEQ]}
                CUR_TX_BYTES=${ARR_TX_BYTES[$SEQ]}
                CUR_RX_BYTES=${ARR_RX_BYTES[$SEQ]}

                TX_PKT=$(( $CUR_TX_PKT - $PREV_TX_PKT ))
                RX_PKT=$(( $CUR_RX_PKT - $PREV_RX_PKT ))
                TX_DROP=$CUR_TX_DROP
                RX_DROP=$CUR_RX_DROP
                TX_BYTES=$(( ($CUR_TX_BYTES - $PREV_TX_BYTES) * 8 / 1000 ))
                RX_BYTES=$(( ($CUR_RX_BYTES - $PREV_RX_BYTES) * 8 / 1000 ))
                SUM_PKTS=$(( $TX_PKT + $RX_PKT ))
                SUM_BPS=$(( $TX_BYTES + $RX_BYTES ))

                printf "%5s %-15s\t%s %10s %10s %10s %s %10s %10s %10s %12s %12s\n" $SEQ $DEV ${blue}TX${normal} $TX_PKT $TX_BYTES $TX_DROP ${green}RX${normal} $RX_PKT $RX_BYTES $RX_DROP $SUM_PKTS $SUM_BPS
	fi
}

declare -a ARR_TX_PKT
declare -a ARR_TX_DROP
declare -a ARR_TX_BYTES
declare -a ARR_RX_PKT
declare -a ARR_RX_DROP
declare -a ARR_RX_BYTES

declare -a PREV_ARR_TX_PKT
declare -a PREV_ARR_TX_DROP
declare -a PREV_ARR_TX_BYTES
declare -a PREV_ARR_RX_PKT
declare -a PREV_ARR_RX_DROP
declare -a PREV_ARR_RX_BYTES


# create empty arrays to record stat
for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        ARR_TX_PKT[$i]=0;   ARR_RX_PKT[$i]=0
        ARR_TX_DROP[$i]=0;  ARR_RX_DROP[$i]=0
        ARR_TX_BYTES[$i]=0; ARR_RX_BYTES[$i]=0

        PREV_ARR_TX_PKT[$i]=0;   PREV_ARR_RX_PKT[$i]=0
        PREV_ARR_TX_DROP[$i]=0;  PREV_ARR_RX_DROP[$i]=0
        PREV_ARR_TX_BYTES[$i]=0; PREV_ARR_RX_BYTES[$i]=0

done

main_loop() {
  while true; do
    for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        DEV=${ITF[$i]}
	get_counter $i $DEV
    done

    printf "%5s %-15s\t%s %10s %10s %10s %s %10s %10s %10s %12s %12s\n" "SEQ" "NIC" ${blue}TX${normal} "TX:pkt/s" "TX:Kbps" "TX_DROP" ${green}RX${normal} "RX:pkt/s" "RX:Kbps" "RX_DROP" "T_PPS" "T_BPS"
    printf "%s\n" "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

    for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        DEV=${ITF[$i]}
	show_counter $i $DEV
    done
    sleep 1
#    echo ""
    clear
  done
}

main_loop
