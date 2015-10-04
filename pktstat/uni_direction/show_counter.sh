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
CFG_DIR=../config

if [ ! -f $CFG_DIR/$CONFIG ]; then
  echo "Error: $CFG_DIR/$CONFIG does not exist!!!"
  exit
else
  source "$CFG_DIR/$CONFIG"
fi

source "../include/pktstat.sh"

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

#        printf "%s %20s %5s %-100s\n" "echo" $CUR_TX_PKT ">>" $LOG_TX_PKT
#        echo $CUR_TX_PKT   >> $LOG_TX_PKT
        echo $CUR_TX_BYTES >> $LOG_TX_BYTES
#        echo $CUR_RX_PKT   >> $LOG_RX_PKT
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

        # get Mbps
        DENOM=`echo "(1000*1000)" | bc`
        TX_BYTES=`echo "scale=2; ($CUR_TX_BYTES - $PREV_TX_BYTES) * 8 / $DENOM" | bc`
        RX_BYTES=`echo "scale=2; ($CUR_RX_BYTES - $PREV_RX_BYTES) * 8 / $DENOM" | bc`

        # get max from rx and tx
        get_max $TX_PKT $RX_PKT MAX_PKTS
        get_max $TX_BYTES $RX_BYTES MAX_BPS

        # if bps is bigger than line rate, divide by 2
        LINERATE=1000
        if [ $(echo "$MAX_BPS > $LINERATE" | bc -l) -eq "1" ]; then 
          MAX_BPS=`echo "scale=2; $MAX_BPS / 2" | bc`
          MAX_PKTS=`echo "scale=2; $MAX_PKTS / 2" | bc`
          # make float to integer
          MAX_PKTS=`printf '%.0f' $MAX_PKTS`
        fi

        if [ $(echo "${ARR_MAX_BPS[$SEQ]}==-1" | bc -l) -eq "1" ]; then 
          ARR_MAX_BPS[$SEQ]=0
        elif [ $(echo "${ARR_MAX_BPS[$SEQ]}<$MAX_BPS" | bc -l) -eq "1" ]; then 
          ARR_MAX_BPS[$SEQ]=$MAX_BPS
        fi

        if [ "${ARR_MAX_PPS[$SEQ]}" -eq "-1" ]; then 
          ARR_MAX_PPS[$SEQ]=0
        elif [ "${ARR_MAX_PPS[$SEQ]}" -lt "$MAX_PKTS" ]; then 
          ARR_MAX_PPS[$SEQ]=$MAX_PKTS
        fi

        #NOW=`date '+%S.%N'`
        NOW=`date '+%H%M%S'`
        printf "%10s %5s %-15s\t%s %10s %10s %10s %s %10s %10s %10s %12s %12s %12s %12.2f\n" \
                                    $NOW \
									$SEQ \
									$DEV \
									${blue}TX${normal} \
									$TX_PKT \
									$TX_BYTES \
									$TX_DROP ${green}RX${normal} \
									$RX_PKT \
									$RX_BYTES \
									$RX_DROP \
									$MAX_PKTS \
									$MAX_BPS \
									${ARR_MAX_PPS[$SEQ]} \
									${ARR_MAX_BPS[$SEQ]}
	fi
}

declare -a ARR_MAX_BPS
declare -a ARR_MAX_PPS

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

MAX_LOAD_AVG=-1

# create empty arrays to record stat
for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
    ARR_MAX_BPS[$i]=-1; ARR_MAX_PPS[$i]=-1
    ARR_TX_PKT[$i]=0;   ARR_RX_PKT[$i]=0
    ARR_TX_DROP[$i]=0;  ARR_RX_DROP[$i]=0
    ARR_TX_BYTES[$i]=0; ARR_RX_BYTES[$i]=0

    PREV_ARR_TX_PKT[$i]=0;   PREV_ARR_RX_PKT[$i]=0
    PREV_ARR_TX_DROP[$i]=0;  PREV_ARR_RX_DROP[$i]=0
    PREV_ARR_TX_BYTES[$i]=0; PREV_ARR_RX_BYTES[$i]=0
done

print_line() {
  local STR=""
  for i in `seq 1 170`; do
    STR="$STR-"
  done
  printf "%s\n" $STR
}

main_loop() {

  print_line
  while true; do
    for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        DEV=${ITF[$i]}
	get_counter $i $DEV
    done

    printf "%10s %5s %-15s\t%5s %10s %10s %10s %5s %10s %10s %10s %12s %12s %12s %12s\n" \
						"NOW" \
						"SEQ" \
						"NIC" \
						${blue}TX${normal} \
						"TX:pkt/s" \
						"TX:Kbps" \
						"TX_DROP" \
						${green}RX${normal} \
						"RX:pkt/s" \
						"RX:Kbps" \
						"RX_DROP" \
						"T_PPS" \
						"T_BPS" \
						"MAX_PPS" \
						"MAX_BPS"
    for (( i = 0 ; i < ${#ITF[@]} ; i++ )) do
        DEV=${ITF[$i]}
        show_counter $i $DEV
    done

    _CUR_LOAD=`get_load_avg`
    get_max $_CUR_LOAD $MAX_LOAD_AVG MAX_LOAD_AVG
    print_line
    printf "%5s %-15s\t%2s %10s %10s %10s %2s %10s %10s %10s %12s %12s %12s %12s\n" "" "" "" "" "" "" "" "" "" "" "" "" "LOAD" "MAX_LOAD"
    printf "%5s %-15s\t%2s %10s %10s %10s %2s %10s %10s %10s %12s %12s %12s %12.2f\n" "" "" "" "" "" "" "" "" "" "" "" "" "$_CUR_LOAD" "$MAX_LOAD_AVG"
    print_line

    sleep 1
#    echo ""
#    clear
  done
}

main_loop
