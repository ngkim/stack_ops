#!/bin/bash

tailf /var/log/kern.log | grep DENY | awk '
{
  if (NF == 22)
    printf("%-10s %-20s %-20s %-10s %-10s\n", $16, $9,$10,$17,$18)
  else if (NF == 23)
    printf("%-10s %-20s %-20s %-10s %-10s\n", $17, $9,$10,$18,$19)
  else
    printf("%5d %-20s %-20s %-10s %-10s %-10s\n", NF, $9,$10,$16,$17,$18)
}
'
