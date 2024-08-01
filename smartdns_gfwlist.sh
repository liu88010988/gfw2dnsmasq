#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
echo "使用 SmartDNS 组：$group"

# 生成并处理 dnsmasq_gfwlist.conf
echo "正在更新 dnsmasq_gfwlist"
sh dnsmasq_gfwlist.sh -o smartdns/dnsmasq_gfwlist.conf >/dev/null 2>&1
cp -f smartdns/dnsmasq_gfwlist.conf smartdns/smartdns_gfwlist.conf

# 替换配置文件中的字段
sed -i -e 's/server=/nameserver\ /g' -e "s/127.0.0.1#5353/$group/g" smartdns/smartdns_gfwlist.conf

# 添加额外的域名
if [[ -f domain/additional_domain.txt ]]; then
  echo "添加额外的域名..."
  while IFS= read -r additional || [[ -n "$additional" ]]; do
    echo "nameserver /$additional/$group" >>smartdns/smartdns_gfwlist.conf
  done <domain/additional_domain.txt
fi

# 删除排除的域名
if [[ -f domain/exclude_domain.txt ]]; then
  echo "删除排除的域名..."
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" smartdns/smartdns_gfwlist.conf
  done <domain/exclude_domain.txt
fi

# 更新 SmartDNS 配置并重启服务
cp -f smartdns/smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
echo "重启 SmartDNS 服务..."
systemctl restart smartdns
