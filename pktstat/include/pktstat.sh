# find max values from given L and R values and return max with $RET
get_max() {
  local L_VAL=$1
  local R_VAL=$2
  local RET=$3

  local MAX=0
  if [ $(echo "$R_VAL==-1" | bc -l) -eq "1" ]; then 
    MAX=0
  elif [ $(echo "$R_VAL<$L_VAL" | bc -l) -eq "1" ]; then 
    MAX=$L_VAL
  else
    MAX=$R_VAL
  fi
 
  eval "$RET=$MAX" 
}

# read load_average and return the first value
get_load_avg() {
  STR=`cat /proc/loadavg`
 
  echo $STR | awk '{print $1}' 
}

# read packet counter
get_pkt_counter() {
	DEV=$1
	MODE=$2
        
        if [ ! -z $DEV ]; then
                STR=`cat /sys/class/net/${DEV}/statistics/${MODE}_packets`
		printf "%s" $STR
        fi
}

# read byte counter
get_byte_counter() {
	local DEV=$1
	local MODE=$2
        
        if [ ! -z $DEV ]; then
                STR=`cat /sys/class/net/${DEV}/statistics/${MODE}_bytes`
		printf "%s" $STR
        fi
}

# read drop counter
get_drop_counter() {
	local DEV=$1
	local MODE=$2
        
        if [ ! -z $DEV ]; then
                STR=`cat /sys/class/net/${DEV}/statistics/${MODE}_dropped`
		printf "%s" $STR
        fi
}
