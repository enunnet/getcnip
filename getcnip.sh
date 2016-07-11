#!/bin/bash

# Fetching china's ipv4 addresses from apnic.net
#
 
SOURCE="http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest"

echo "Fetching data from apnic.net, it might take a few minutes, please wait..."
echo ""
for i in `curl ${SOURCE} | awk -F'|' '/CN\|ipv4/{printf("%s#%s\n",$4,$5);}'`
do
    NETMASK=$((32-`echo "obase=2;$((${i##*#}-2))" | bc | wc -L`))
    echo "${i%%#*}/${NETMASK}" | tee -a cn_ip4.txt
done
echo "Done."
exit
