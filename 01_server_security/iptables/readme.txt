1) copy 00-iptables.up.rules/[latest iptables.up.rules] with a new [date]_iptables.up.rules
2) create a link for the newly created iptables.up.rules
3) add a new entry to allow traffic from a new sites to ktrnd_sites or trusted_zones
4) you can check packets dropped by the netfilter by running
   
   # tailf /var/log/kern.log | grep DENY
