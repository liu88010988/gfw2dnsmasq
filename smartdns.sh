#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
work_dir="/etc/smartdns"

mkdir -p "$work_dir"

echo "$(date '+%Y-%m-%d %H:%M:%S') 开始更新并重启SmartDNS服务..."
echo "$(date '+%Y-%m-%d %H:%M:%S') 使用SmartDNS组:$group..."
bash update-data.sh "$group"

# 更新 SmartDNS 配置并重启服务
cp -f smartdns/smartdns_proxy.conf smartdns/smartdns_gfwlist.conf "$work_dir"
echo "$(date '+%Y-%m-%d %H:%M:%S') 重启SmartDNS服务..."
systemctl restart smartdns
echo "$(date '+%Y-%m-%d %H:%M:%S') 更新并重启SmartDNS服务完成..."
