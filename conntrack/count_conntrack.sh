#!/bin/bash

tcp_conntrack() {
#echo "- TCP"
conntrack -L 2> /dev/null | awk '
BEGIN {
  tcp_conn_count=0
  tcp_conn_time_wait_count=0
  tcp_conn_estab_count=0
  tcp_conn_etc_count=0
  tcp_conn_syn_sent_count=0
  tcp_conn_close_count=0
}
/tcp/{
  if($4 == "ESTABLISHED") {
    tcp_conn_estab_count = tcp_conn_estab_count + 1;
  } else if ($4 == "TIME_WAIT") {
    tcp_conn_time_wait_count = tcp_conn_time_wait_count + 1;
  } else if($4 == "SYN_SENT") {
    tcp_conn_syn_sent_count = tcp_conn_syn_sent_count + 1;
  } else if($4 == "CLOSE") {
    tcp_conn_close_count = tcp_conn_close_count + 1;
  } else {
    #print $4
    tcp_conn_etc_count = tcp_conn_etc_count + 1;
  }
  tcp_conn_count = tcp_conn_count + 1;
}
END { 
  printf("TOTAL_TCP_CONN= %10s ESTABLISHED= %10s SYN_SENT= %10s TIME_WAIT= %10d CLOSE= %10s ETC= %10s\n", tcp_conn_count, tcp_conn_estab_count, tcp_conn_syn_sent_count, tcp_conn_time_wait_count, tcp_conn_close_count, tcp_conn_etc_count); 
}'
#' | sort -k 2
#' | sort -k 2
}

udp_conntrack() {
echo "- UDP"
conntrack -L 2> /dev/null | awk '
/udp/{
printf("%-3s %-20s %-20s %-12s %-12s %-20s %-20s %-12s %-12s\n",$1,$4,$5,$6,$7,$8,$9,$10,$11);
}
' | sort -k 2
}

while [ 1 ]; do
  tcp_conntrack
  sleep 1
done
#udp_conntrack
