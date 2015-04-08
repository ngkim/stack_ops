source "../include/command_util.sh"

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

