#!/bin/bash

source "00_check_input.sh"

tail -n 8 $LOG_COUNTER | awk '
{
  if ( NF == 2 ) {
    if ($2 != "MAX_LOAD" ) printf ("MAX LOAD= %9s\n", $2)
  } else if ( NF == 14 ) {
    if ( $13 != "MAX_PPS" ) printf ("MAX BPS= %10s MAX PPS= %s\n", $14, $13)
  }
}
'

