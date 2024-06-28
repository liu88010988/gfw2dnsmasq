#! /bin/sh
#
# Update GFWList
rm -rf /etc/smartdns/dnsmasq_gfwlist.conf
sh dnsmasq_gfwlist.sh -o /etc/smartdns/dnsmasq_gfwlist.conf
sed -i 's/server=/nameserver\ /g' /etc/smartdns/dnsmasq_gfwlist.conf
sed -i 's/127.0.0.1#5353/gfwlist/g' /etc/smartdns/dnsmasq_gfwlist.conf
sed -i '/m-team.cc/d' /etc/smartdns/dnsmasq_gfwlist.conf
echo 'nameserver /javdb.com/gfwlist' >> /etc/smartdns/dnsmasq_gfwlist.conf
echo 'nameserver /ipleak.net/gfwlist' >> /etc/smartdns/dnsmasq_gfwlist.conf
echo 'nameserver /docker.com/gfwlist' >> /etc/smartdns/dnsmasq_gfwlist.conf
echo 'restart smartdns'
systemctl restart smartdns
