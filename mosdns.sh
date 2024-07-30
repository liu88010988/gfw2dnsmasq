#!/bin/bash

# 定义工作目录
work_dir="/etc/mosdns"

# 创建工作目录（如果不存在）
mkdir -p "$work_dir"

# 配置文件的URL和本地路径
declare -A files=(
  ["https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt"]="ip/geoip_cn.txt"
  ["https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt"]="domain/apple-cn.txt"
  ["https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt"]="domain/direct-list.txt"
  ["https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt"]="domain/proxy-list.txt"
)

# 下载并复制配置文件
for url in "${!files[@]}"; do
  local_path="${files[$url]}"
  echo "正在下载 $url 到 $local_path"
  curl -s -L "$url" -o "$local_path" || { echo "下载失败: $url"; exit 1; }
  cp -f "$local_path" "$work_dir"
done

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

