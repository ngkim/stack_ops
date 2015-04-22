#!/bin/bash

tail -n 8 1-vm/trial-1/counter/counter.log | awk '
{
  if ( NF == 2 ) {
    if ($2 != "MAX_LOAD" ) printf ("MAX LOAD= %9s\n", $2)
  } else if ( NF == 14 ) {
    if ( $13 != "MAX_PPS" ) printf ("MAX BPS= %10s MAX PPS= %s\n", $13, $14)
  }
}
'

