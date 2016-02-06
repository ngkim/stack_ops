#!/usr/bin/python

import sys
import pygeoip

gi = pygeoip.GeoIP('GeoLiteCity.dat')

def printRecord(tgt):
    rec = gi.record_by_name(tgt)
    city = rec['city']
    country = rec['country_name']
    #print '[*] Target: ' + tgt + ' Geo-located. '
    #print '[+] ' + str(country)
    print str(country)


def main(argv):
    tgt = "220.123.31.119"
    tgt = argv[0]
    printRecord(tgt)


if __name__ == "__main__":
   main(sys.argv[1:])
