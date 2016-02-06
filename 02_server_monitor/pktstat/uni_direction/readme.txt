****************************************************************
  - Show pps,bps,load average for unidirection
    . max data rate is the bigger one between rx and tx bps
****************************************************************

1) Usage
   ./show_counter.sh vUTM-0.cfg

2) Configuration
  - use a config file in ../config directory (e.g., vUTM-0.cfg)
    . set ITF list as follows
      ITF[0]="eth0"
      ITF[1]="eth1"
  - this will print max packet rate and max data rate
    . currently, it is configured to print data rate as mega bps
    . to print data rate as giga bps, set DENOM variable as follows
        (Giga bps) DENOM=`echo "(1000*1000*1000)" | bc`
        (Mega bps) DENOM=`echo "(1000*1000)" | bc`

3) Note
    . if max data rate is bigger than line rate, divide it by 2 before print
    . line rate can be configured by setting  LINERATE variable
        LINERATE=1000

