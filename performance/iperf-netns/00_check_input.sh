WORK_HOME="$HOME/bin"

source "$WORK_HOME/include/command_util.sh"

if [ -z $1 ]; then
  echo "Usage: $0 [TEST_ID]"
  echo "   ex: $0 0"
  exit
fi

TEST_ID=$1

CONFIG="config/00_test.cfg"
if [ ! -f $CONFIG ]; then
  echo "Error: $CONFIG does not exist!!!"
  exit
else
  source "$CONFIG"
fi

