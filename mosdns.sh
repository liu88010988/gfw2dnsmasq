#!/bin/bash

# 定义工作目录
work_dir="/etc/mosdns"
ip_dir="$work_dir/ip"
domain_dir="$work_dir/domain"
hosts_dir="$work_dir/hosts"

# 创建工作目录（如果不存在）
mkdir -p "$ip_dir" "$domain_dir" "$hosts_dir"

# 更新并复制配置文件
./update-data.sh

cp -f ip/geoip_cn.txt ip/geoip_private.txt "$ip_dir"
cp -f domain/geosite_apple-cn.txt domain/geosite_google-cn.txt domain/geosite_cn.txt \
  domain/geosite_private.txt domain/geosite_geolocation-!cn.txt \
  domain/geosite_tld-cn.txt domain/geosite_category-games@cn.txt \
  domain/cdn_domain_list.txt "$domain_dir"
cp -f hosts/hosts.txt "$hosts_dir"
cp -f mosdns/mosdns.yaml "$work_dir"

# 检查并启用 mosdns 服务
service_file="/etc/systemd/system/mosdns.service"
if [[ ! -f $service_file ]]; then
  echo "安装 mosdns 服务..."
  cp mosdns/mosdns.service "$service_file"
  systemctl daemon-reload
  systemctl enable mosdns
  systemctl start mosdns
fi

# 重启 mosdns 服务
echo '重启 mosdns 服务'
systemctl restart mosdns
