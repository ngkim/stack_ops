#!/bin/bash

echo "- TCP"
conntrack -L 2> /dev/null | awk '
/tcp/{
  if($4 == "SYN_SENT") {
    printf("%-3s %-12s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$10,$11,$12,$13);
  } else {
    printf("%-3s %-12s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$9,$10,$11,$12);
  }
}
' | sort -k 2

echo "- UDP"
conntrack -L 2> /dev/null | awk '
/udp/{
printf("%-3s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$9,$10,$11);
}
' | sort -k 2
