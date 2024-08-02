#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
system=${1:-linux}
group=${2:-gfwlist}
echo "使用 SmartDNS 组：$group"

echo "生成 SmartDNS 配置..."
./update-data.sh "$system" "$group"

# 更新 SmartDNS 配置并重启服务
echo "更新 SmartDNS 配置并重启服务..."
cp -f smartdns/smartdns_proxy.conf /etc/smartdns/smartdns_proxy.conf
systemctl restart smartdns
