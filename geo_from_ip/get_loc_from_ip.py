import pygeoip

gi = pygeoip.GeoIP('/root/GeoLiteCity.dat')

def printRecord(tgt):
    rec = gi.record_by_name(tgt)
    city = rec['city']
    country = rec['country_name']
    print '[*] Target: ' + tgt + ' Geo-located. '
    print '[+] ' + str(country)

tgt = "220.123.31.119"
printRecord(tgt)
