#!/bin/bash

tcp_conntrack() {
echo "- TCP"
conntrack -L 2> /dev/null | awk '
BEGIN {
  tcp_conn_count=0
  tcp_conn_time_wait_count=0
  tcp_conn_estab_count=0
  tcp_conn_syn_sent_count=0
}
/tcp/{
  if($4 == "ESTABLISHED") {
    printf("%-3s %-12s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$9,$10,$11,$12);
    tcp_conn_estab_count++;
  } else if ($4 == "TIME_WAT") {
    tcp_conn_time_wait_count++;
  }
  if($4 == "SYN_SENT") {
    #printf("%-3s %-12s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$10,$11,$12,$13);
    tcp_conn_syn_sent_count++;
  } else {
    #printf("%-3s %-12s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$9,$10,$11,$12);
  }
  tcp_conn_count++;
}
' | sort -k 2
}

udp_conntrack() {
echo "- UDP"
conntrack -L 2> /dev/null | awk '
/udp/{
printf("%-3s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$9,$10,$11);
}
' | sort -k 2
}

tcp_conntrack
#udp_conntrack
