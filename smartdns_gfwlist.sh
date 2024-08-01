#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
echo "使用 SmartDNS 组：$group"

# 生成并处理 dnsmasq_gfwlist.conf
./update-data.sh
cp -f smartdns/dnsmasq_gfwlist.conf smartdns/smartdns_gfwlist.conf

# 替换配置文件中的字段
sed -i -e 's/server=/nameserver\ /g' -e "s/127.0.0.1#5353/$group/g" smartdns/smartdns_gfwlist.conf

# 更新 SmartDNS 配置并重启服务
cp -f smartdns/smartdns_gfwlist.conf /etc/smartdns/smartdns_gfwlist.conf
echo "重启 SmartDNS 服务..."
systemctl restart smartdns
