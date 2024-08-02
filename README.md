# 本项目用于拉取gfwlist的域名并转换

## 一.转换成dnsmasq格式

```sh
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
```

## 二.使用dnsmasq_gfwlist.conf转换成smartdns格式，后面传入smartdns的国外解析分组名，不传默认为gfwlist

```sh
sh smartdns_gfwlist.sh $group_name
```

## 三.使用geosite_geolocation-!cn.txt转换成smartdns格式，后面传入smartdns的国外解析分组名，不传默认为gfwlist

```sh
sh smartdns_proxy.sh $group_name

```

## 四.转换成mosdns格式

```sh
sh mosdns.sh
```

## 五.domain文件夹说明

| 文件名                         | 描述             |
|-----------------------------|----------------|
| exclude_domain.txt          | 国外代理域名列表中排除的域名 |
| apple-cn.txt                | apple国内域名列表    |
| geosite_cn.txt              | 国内域名列表         |
| geosite_geolocation-!cn.txt | 国外代理域名列表       |
| google-cn.txt               | google国内域名列表   |

## 六.ip文件夹说明

| 文件名               | 描述     |
|-------------------|--------|
| geoip_cn.txt      | 国内ip列表 |
| geoip_private.txt | 内网ip列表 |

## 七.该项目仅为个人测试使用，如有侵权请联系，会及时调整