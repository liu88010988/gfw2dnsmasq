#!/bin/bash

# 定义工作目录
work_dir="/etc/mosdns"

# 创建工作目录（如果不存在）
mkdir -p "$work_dir"

# 更新并复制配置文件
./update-data.sh

# 删除排除的域名
exclude_file="domain/exclude_domain.txt"
if [[ -f $exclude_file ]]; then
  echo "删除排除的域名..."
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" "domain/proxy-list.txt"
  done <"$exclude_file"
  cp -f "domain/proxy-list.txt" "$work_dir"
fi

# 复制其他配置文件
cp -f mosdns/hosts.txt "$work_dir"
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
