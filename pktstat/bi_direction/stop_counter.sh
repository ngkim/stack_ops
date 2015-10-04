#!/bin/bash

PID_FILE=".pid"

if [ -f $PID_FILE ]; then
  _PID=`cat $PID_FILE`
  kill $_PID
  rm $PID_FILE
fi
