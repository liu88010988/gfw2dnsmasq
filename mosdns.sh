#! /bin/bash

work_dir="/etc/mosdns"

if [ ! -d "$work_dir" ]; then
  mkdir -p "$work_dir"
fi

# 配置文件拷贝
curl -L https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt -o ip/geoip_cn.txt
cp -f ip/geoip_cn.txt "$work_dir"

curl -L https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt -o domain/apple-cn.txt
cp -f domain/apple-cn.txt "$work_dir"

curl -L https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt -o domain/direct-list.txt
cp -f domain/direct-list.txt "$work_dir"

curl -L https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt -o domain/proxy-list.txt
# 删除排除的域名
if [[ -f domain/exclude_domain.txt ]]; then
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" domain/proxy-list.txt
  done <domain/exclude_domain.txt
fi
cp -f domain/proxy-list.txt "$work_dir"

cp -f mosdns/hosts.txt "$work_dir"
cp -f mosdns/mosdns.yaml "$work_dir"

script_name=$(basename "$0")
pid=$(pgrep -f "mosdns.yaml" | grep -v "$script_name" | grep -v "grep")
# 如果找到进程，则杀死它
if [ -n "$pid" ]; then
  echo "killing existing mosdns PID: $pid"
  kill -9 "$pid"
  echo "Process mosdns $pid has terminated."
fi

# 启动mosdns
echo 'restart mosdns'
systemctl enable mosdns
