WORK_HOME="$HOME/bin"

source "$WORK_HOME/include/command_util.sh"

if [ -z $2 ]; then
  echo "Usage: $0 [START] [END]"
  echo "   ex) $0 3 5"
  exit
fi

START=$1
END=$2


