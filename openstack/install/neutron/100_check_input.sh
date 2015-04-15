WORK_HOME="$HOME/bin"

source "$WORK_HOME/include/command_util.sh"

if [ -z $1 ]; then
  echo "Usage: $0 [TEST_ID]"
  echo "   ex: $0 0"
  exit
fi

TEST_ID=$1

CONFIG="config/provider-net.ini"
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


