#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
echo "使用 SmartDNS 组：$group"

# 更新 proxy-list.txt 文件
./update-data.sh

# 处理并生成 smartdns_proxy.conf
echo "生成 SmartDNS 配置..."
cp -f domain/proxy-list.txt smartdns/smartdns_proxy.conf
sed -i -e 's/^/nameserver\ \//' \
  -e "s/$/\/$group/" \
  -e 's/full://g' \
  -e "/regexp:/d" smartdns/smartdns_proxy.conf

# 更新 SmartDNS 配置并重启服务
echo "更新 SmartDNS 配置并重启服务..."
cp -f smartdns/smartdns_proxy.conf /etc/smartdns/smartdns_proxy.conf
systemctl restart smartdns
