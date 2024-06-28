#! /bin/bash

sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
cp -f dnsmasq_gfwlist.conf smartdns_gfwlist.conf
sed -i 's/server=/nameserver\ /g' smartdns_gfwlist.conf
sed -i 's/127.0.0.1#5353/gfwlist/g' smartdns_gfwlist.conf
while IFS= read -r addLine || [[ -n "$addLine" ]]; do
  echo "nameserver /$addLine/gfwlist" >>smartdns_gfwlist.conf
done < addon_domain

while IFS= read -r deleteLine || [[ -n "$deleteLine" ]]; do
  sed -i "/$deleteLine/d" smartdns_gfwlist.conf
done < delete_domain

git add .
git commit -m 'update'
git push
git push -f https://gitee.com/hz-liujiawei/gfw2dnsmasq.git master
#cp -f smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
#echo 'restart smartdns'
#systemctl restart smartdns
