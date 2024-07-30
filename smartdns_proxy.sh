#! /bin/bash

group=$1
if [ -z "$group" ]; then
  group=gfwlist
fi
echo "use smartdns group $group"

curl -L https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt -o domain/proxy-list.txt
# 删除排除的域名
if [[ -f domain/exclude_domain.txt ]]; then
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" domain/proxy-list.txt
  done <domain/exclude_domain.txt
fi
cp -f domain/proxy-list.txt smartdns/smartdns_proxy.conf
sed -i 's/^/nameserver\ \//g' smartdns/smartdns_proxy.conf
sed -i "s/$/\/$group/g" smartdns/smartdns_proxy.conf
sed -i 's/full://g' smartdns/smartdns_proxy.conf
sed -i "/regexp:/d" smartdns/smartdns_proxy.conf

# 更新并重启smartdns
cp -f smartdns/smartdns_proxy.conf /etc/smartdns/smartdns_proxy.conf
echo 'restart smartdns'
systemctl restart smartdns
