#!/bin/bash

usage() {
  echo "Usage: $0 [STACK_NAME]"
  echo "   ex) $0 mystack"
  exit 1
}

if [ -z $1 ]; then
  usage
fi

STACK_NAME=$1

heat stack-delete $STACK_NAME
