#!/bin/bash
#
# sweet-dns network changes watch utility script
#
# Definitions
prefix=$(brew --prefix)
dnsmasqdir=$prefix/etc/dnsmasq/dnsmasq.d
iface=$(route get example.com | grep interface | awk '{print $2}')
netservice=$(networksetup -listnetworkserviceorder | grep $iface | sed s/[,]/""/g | awk '{print $3}')
#Main
cat /private/var/run/resolv.conf > $dnsmasqdir/connection_resolv.conf
networksetup -setdnsservers $netservice 127.0.0.1
if [[ ! $? -eq 0 ]]; then exit 1; else exit 0; fi
