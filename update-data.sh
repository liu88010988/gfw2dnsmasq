#!/bin/bash

group=${1:-gfwlist}
# URLs 和文件路径
ip_path="ip"
domain_path="domain"
smartdns_path="smartdns"
base_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release"

geoip_url="$base_url/geoip.dat"
geoip_path="$ip_path/geoip.dat"

geosite_url="$base_url/geosite.dat"
geosite_path="$domain_path/geosite.dat"

apple_cn_url="$base_url/apple-cn.txt"
apple_cn_path="$domain_path/apple-cn.txt"

google_cn_url="$base_url/google-cn.txt"
google_cn_path="$domain_path/google-cn.txt"

geosite_no_cn_file="$domain_path/geosite_geolocation-!cn.txt"
geosite_gfw_file="$domain_path/geosite_gfw.txt"
dnsmasq_gfwlist_file="$smartdns_path/dnsmasq_gfwlist.conf"
smartdns_gfwlist_file="$smartdns_path/smartdns_gfwlist.conf"
smartdns_proxy_file="$smartdns_path/smartdns_proxy.conf"
exclude_file="$domain_path/exclude_domain.txt"

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
download_file "$geoip_url" "$geoip_path"
download_file "$geosite_url" "$geosite_path"
./v2dat-linux unpack geoip -o "$ip_path" -f cn -f private "$geoip_path"
./v2dat-linux unpack geosite -o "$domain_path" -f gfw -f cn -f 'geolocation-!cn' "$geosite_path"
download_file "$apple_cn_url" "$apple_cn_path"
download_file "$google_cn_url" "$google_cn_path"
#sh dnsmasq_gfwlist.sh -o "$dnsmasq_gfwlist_file" >/dev/null 2>&1

# 删除排除的域名
if [[ -f "$exclude_file" ]]; then
  echo "删除排除的域名..."
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" "$geosite_no_cn_file"
    sed -i "/$exclude/d" "$geosite_gfw_file"
  done <"$exclude_file"
fi

echo "正在更新 smartdns_proxy.conf"
cp -f "$geosite_no_cn_file" "$smartdns_proxy_file"
sed -i -e 's/^/nameserver\ \//' \
  -e "s/$/\/$group/" \
  -e 's/full://g' \
  -e "/regexp:/d" "$smartdns_proxy_file"

echo "正在更新 dnsmasq_gfwlist.conf"
cp -f "$geosite_gfw_file" "$dnsmasq_gfwlist_file"
sed -i -e 's/^/server=\//' \
  -e "s/$/\/127.0.0.1#5353/" "$dnsmasq_gfwlist_file"

echo "正在更新 smartdns_gfwlist.conf"
cp -f "$dnsmasq_gfwlist_file" "$smartdns_gfwlist_file"
sed -i -e 's/server=/nameserver\ /g' -e "s/127.0.0.1#5353/$group/g" "$smartdns_gfwlist_file"
