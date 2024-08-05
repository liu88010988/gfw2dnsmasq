#!/bin/bash

# 获取用户输入的组名，如果没有输入，则默认使用 "gfwlist"
group=${1:-gfwlist}
work_dir="/etc/smartdns"
daily_log="$work_dir/daily.log"

mkdir -p "$work_dir"
touch $daily_log

echo "开始更新并重启SmartDNS服务...$(date)" >>"$daily_log"
echo "使用SmartDNS组:$group...$(date)" >>"$daily_log"

echo "生成SmartDNS配置...$(date)" >>"$daily_log"
bash update-data.sh $daily_log "$group"

# 更新 SmartDNS 配置并重启服务
cp -f smartdns/smartdns_proxy.conf smartdns/smartdns_gfwlist.conf $work_dir
echo "重启SmartDNS服务...$(date)" >>"$daily_log"
systemctl restart smartdns
echo "更新并重启SmartDNS服务完成...$(date)" >>"$daily_log"
