#!/bin/bash

group=${1:-gfwlist}
# 文件路径
ip_path="ip"
domain_path="domain"
smartdns_path="smartdns"
dnsmasq_path="dnsmasq"
geoip_path="$ip_path/geoip.dat"
geosite_path="$domain_path/geosite.dat"
geosite_no_cn_file="$domain_path/geosite_geolocation-!cn.txt"
geosite_gfw_file="$domain_path/geosite_gfw.txt"
dnsmasq_gfwlist_file="$dnsmasq_path/dnsmasq_gfwlist.conf"
smartdns_gfwlist_file="$smartdns_path/smartdns_gfwlist.conf"
smartdns_proxy_file="$smartdns_path/smartdns_proxy.conf"
exclude_file="$domain_path/exclude_domain.txt"
# URLs
base_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release"
geoip_url="$base_url/geoip.dat"
geosite_url="$base_url/geosite.dat"

print_msg() {
  local msg=$1
  echo "$(date '+%Y-%m-%d %H:%M:%S') $msg..."
}

# 下载文件并处理错误的函数
download_file() {
  local url=$1
  local path=$2
  print_msg "正在更新 $url 到 $path"
  if ! curl -s -L "$url" -o "$path"; then
    print_msg "更新失败: $url"
    exit 1
  fi
}

system="linux"
if [[ "$OSTYPE" == "darwin"* ]]; then
  system="mac"
fi
print_msg "更新dns基础数据开始 system $system"

# 下载文件
download_file "$geoip_url" "$geoip_path"
download_file "$geosite_url" "$geosite_path"
./v2dat-"$system" unpack geoip -o "$ip_path" -f 'telegram' -f 'cn' -f 'private' "$geoip_path"
./v2dat-"$system" unpack geosite -o "$domain_path" -f 'category-ads-all' -f 'apple-cn' -f 'google-cn' -f 'private' -f 'tld-cn' -f 'category-games@cn' -f 'gfw' -f 'cn' -f 'geolocation-!cn' "$geosite_path"

# 删除排除的域名
if [[ -f "$exclude_file" ]]; then
  print_msg "删除排除的域名"
  while IFS= read -r exclude || [[ -n "$exclude" ]]; do
    sed -i "/$exclude/d" "$geosite_no_cn_file"
    sed -i "/$exclude/d" "$geosite_gfw_file"
  done <"$exclude_file"
fi

print_msg "正在更新 smartdns_proxy.conf"
cp -f "$geosite_no_cn_file" "$smartdns_proxy_file"
sed -i -e 's/^/nameserver\ \//' \
  -e "s/$/\/$group/" \
  -e 's/full://g' \
  -e "/regexp:/d" "$smartdns_proxy_file"

print_msg "正在更新 dnsmasq_gfwlist.conf"
cp -f "$geosite_gfw_file" "$dnsmasq_gfwlist_file"
sed -i -e 's/^/server=\//' \
  -e "s/$/\/127.0.0.1#5353/" "$dnsmasq_gfwlist_file"

print_msg "正在更新 smartdns_gfwlist.conf"
cp -f "$geosite_gfw_file" "$smartdns_gfwlist_file"
sed -i -e 's/^/nameserver\ \//' \
  -e "s/$/\/$group/" "$smartdns_gfwlist_file"
print_msg "更新dns基础数据完成 system $system"
