#! /bin/bash

# 更新代码库
git pull

# 生成并处理dnsmasq_gfwlist.conf
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
cp -f dnsmasq_gfwlist.conf smartdns_gfwlist.conf
sed -i 's/server=/nameserver\ /g' smartdns_gfwlist.conf
sed -i 's/127.0.0.1#5353/gfwlist/g' smartdns_gfwlist.conf

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

# 提交并推送更改
sh push_git.sh

# 更新并重启smartdns
cp -f smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
echo 'restart smartdns'
systemctl restart smartdns
