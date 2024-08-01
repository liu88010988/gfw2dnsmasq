#!/bin/bash

# URLs 和文件路径
geoip_cn_url="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt"
geoip_cn_path="ip/geoip_cn.txt"

apple_cn_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt"
apple_cn_path="domain/apple-cn.txt"

direct_list_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt"
direct_list_path="domain/direct-list.txt"

proxy_list_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt"
proxy_list_path="domain/proxy-list.txt"

# 下载文件并处理错误的函数
download_file() {
  local url=$1
  local path=$2
  echo "正在更新 $url 到 $path"
  if ! curl -s -L "$url" -o "$path"; then
    echo "更新失败: $url"
    exit 1
  fi
}

# 下载文件
download_file "$geoip_cn_url" "$geoip_cn_path"
download_file "$apple_cn_url" "$apple_cn_path"
download_file "$direct_list_url" "$direct_list_path"
download_file "$proxy_list_url" "$proxy_list_path"

echo "正在更新 dnsmasq_gfwlist"
sh dnsmasq_gfwlist.sh -o smartdns/dnsmasq_gfwlist.conf >/dev/null 2>&1
