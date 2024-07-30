#! /bin/bash

group=$1
if [ -z "$group" ]; then
  group=gfwlist
fi
echo "use smartdns group $group"

cp -f domain/proxy-list.txt smartdns/smartdns_proxy.conf
sed -i 's/^/nameserver\ \//g' smartdns/smartdns_proxy.conf
sed -i "s/$/\/$group/g" smartdns/smartdns_proxy.conf
sed -i 's/full://g' smartdns/smartdns_proxy.conf
sed -i "/regexp:/d" smartdns/smartdns_proxy.conf

# 更新并重启smartdns
cp -f smartdns/smartdns_proxy.conf /etc/smartdns/smartdns_proxy.conf
echo 'restart smartdns'
systemctl restart smartdns
