#!/bin/bash

# 下载并复制配置文件
geoip_cn_url="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt"
geoip_cn_path="ip/geoip_cn.txt"
echo "正在下载 $geoip_cn_url 到 $geoip_cn_path"
curl -s -L "$geoip_cn_url" -o "$geoip_cn_path" || {
  echo "下载失败: $geoip_cn_url"
  exit 1
}

apple_cn_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt"
apple_cn_path="domain/apple-cn.txt"
echo "正在下载 $apple_cn_url 到 $apple_cn_path"
curl -s -L "$apple_cn_url" -o "$apple_cn_path" || {
  echo "下载失败: $apple_cn_url"
  exit 1
}

direct_list_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt"
direct_list_path="domain/direct-list.txt"
echo "正在下载 $direct_list_url 到 $direct_list_path"
curl -s -L "$direct_list_url" -o "$direct_list_path" || {
  echo "下载失败: $direct_list_url"
  exit 1
}

proxy_list_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt"
proxy_list_path="domain/proxy-list.txt"
echo "正在下载 $proxy_list_url 到 $proxy_list_path"
curl -s -L "$proxy_list_url" -o "$proxy_list_path" || {
  echo "下载失败: $proxy_list_url"
  exit 1
}

echo "正在下载 dnsmasq_gfwlist"
sh dnsmasq_gfwlist.sh -o smartdns/dnsmasq_gfwlist.conf >/dev/null 2>&1
