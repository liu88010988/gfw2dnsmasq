#! /bin/bash

group=$1
if [ -z "$group" ]; then
  group=gfwlist
fi
# 生成并处理dnsmasq_gfwlist.conf
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
cp -f dnsmasq_gfwlist.conf smartdns_gfwlist.conf
sed -i 's/server=/nameserver\ /g' smartdns_gfwlist.conf
sed -i "s/127.0.0.1#5353/$group/g" smartdns_gfwlist.conf

# 添加额外的域名
if [[ -f domain/additional_domain.txt ]]; then
  while IFS= read -r additional || [[ -n "$additional" ]]; do
    echo "nameserver /$additional/gfwlist" >>smartdns_gfwlist.conf
  done <domain/additional_domain.txt
fi

# 删除排除的域名
if [[ -f domain/exclude_domain.txt ]]; then
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" smartdns_gfwlist.conf
  done <domain/exclude_domain.txt
fi

# 更新并重启smartdns
cp -f smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
echo 'restart smartdns'
systemctl restart smartdns
