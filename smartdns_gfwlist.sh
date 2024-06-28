#! /bin/bash

# 更新代码库
git pull

# 生成并处理dnsmasq_gfwlist.conf
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
cp -f dnsmasq_gfwlist.conf smartdns_gfwlist.conf
sed -i 's/server=/nameserver\ /g' smartdns_gfwlist.conf
sed -i 's/127.0.0.1#5353/gfwlist/g' smartdns_gfwlist.conf

# 添加额外的域名
while IFS= read -r addLine || [[ -n "$addLine" ]]; do
  echo "nameserver /$addLine/gfwlist" >>smartdns_gfwlist.conf
done <domain/additional_domain.txt

# 删除排除的域名
while IFS= read -r deleteLine || [[ -n "$deleteLine" ]]; do
  sed -i "/$deleteLine/d" smartdns_gfwlist.conf
done <domain/exclude_domain.txt

# 提交并推送更改
git add .
git commit -m 'update'
git push
git push -f https://gitee.com/hz-liujiawei/gfw2dnsmasq.git master

# 更新并重启smartdns
cp -f smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
echo 'restart smartdns'
systemctl restart smartdns
