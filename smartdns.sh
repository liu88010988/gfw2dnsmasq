#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
work_dir="/etc/smartdns"

print_msg() {
  local msg=$1
  echo "$(date '+%Y-%m-%d %H:%M:%S') $msg..."
}

mkdir -p "$work_dir"

print_msg "开始更新并重启SmartDNS服务,使用SmartDNS组:$group"
bash update-geo.sh "$group"

# 更新 SmartDNS 配置并重启服务
cp -f smartdns/smartdns_proxy.conf smartdns/smartdns_gfwlist.conf "$work_dir"
print_msg "重启SmartDNS服务"
systemctl restart smartdns
print_msg "更新并重启SmartDNS服务完成"
