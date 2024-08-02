#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
echo "使用 SmartDNS 组：$group"

echo "生成 SmartDNS 配置..."
./update-data.sh "$group"

# 更新 SmartDNS 配置并重启服务
cp -f smartdns/smartdns_proxy.conf smartdns/smartdns_gfwlist.conf /etc/smartdns/
echo "重启 SmartDNS 服务..."
systemctl restart smartdns
