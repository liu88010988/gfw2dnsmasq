#! /bin/sh
#
# Update GFWList
# rm -rf /etc/smartdns/dnsmasq_gfwlist.conf
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
cp -f dnsmasq_gfwlist.conf smartdns_gfwlist.conf
sed -i 's/server=/nameserver\ /g' smartdns_gfwlist.conf
sed -i 's/127.0.0.1#5353/gfwlist/g' smartdns_gfwlist.conf
sed -i '/m-team.cc/d' smartdns_gfwlist.conf
echo 'nameserver /javdb.com/gfwlist' >> smartdns_gfwlist.conf
echo 'nameserver /ipleak.net/gfwlist' >> smartdns_gfwlist.conf
echo 'nameserver /docker.com/gfwlist' >> smartdns_gfwlist.conf
git add .
git commit -m 'update'
git push
git push -f https://gitee.com/hz-liujiawei/gfw2dnsmasq.git master
cp -f smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
#echo 'restart smartdns'
#systemctl restart smartdns
