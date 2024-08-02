# 本项目用于拉取gfwlist的域名并转换

## 一.转换成dnsmasq格式

```sh
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
```

## 二.转换成smartdns格式，后面传入smartdns的国外解析分组名，不传默认为gfwlist

```sh
sh smartdns.sh $group_name
```

## 三.转换成mosdns格式

```sh
sh mosdns.sh
```

## 四.domain文件夹说明

| 文件名                         | 描述             |
|-----------------------------|----------------|
| apple-cn.txt                | apple国内域名列表    |
| exclude_domain.txt          | 国外代理域名列表中排除的域名 |
| geosite.dat                 | geosite全量原始数据  |
| geosite_cn.txt              | 国内域名列表         |
| geosite_geolocation-!cn.txt | 国外代理域名列表       |
| geosite_gfw.txt             | gwf域名列表        |
| google-cn.txt               | google国内域名列表   |

## 五.ip文件夹说明

| 文件名               | 描述          |
|-------------------|-------------|
| geoip.dat         | geoip全量原始数据 |
| geoip_cn.txt      | 国内ip列表      |
| geoip_private.txt | 内网ip列表      |

## 六.该项目仅为个人测试使用，如有侵权请联系，会及时调整