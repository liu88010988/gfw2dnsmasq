# 本项目用于拉取gfwlist的域名并转换

## 一.转换成dnsmasq格式

```sh
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
```

## 二.使用dnsmasq_gfwlist.conf转换成smartdns格式，后面传入smartdns的国外解析分组名，不传默认为gfwlist

```sh
sh smartdns_gfwlist.sh $group_name
```

## 三.使用proxy-list.txt转换成smartdns格式，后面传入smartdns的国外解析分组名，不传默认为gfwlist

```sh
sh smartdns_proxy.sh $group_name

```

## 四.转换成mosdns格式

```sh
sh mosdns.sh
```

## 五.domain文件夹说明

| 文件名                   | 描述                        |
|-----------------------|---------------------------|
| additional_domain.txt | 追加国外代理域名列表                |
| exclude_domain.txt    | 追加非国外代理域名列表               |
| apple-cn.txt          | mosdns中国内域名对于apple域名的补充列表 |
| direct-list.txt       | mosdns中定义的国内域名列表          |
| proxy-list.txt        | mosdns中定义的国外代理域名列表        |

## 六.ip文件夹说明

| 文件名          | 描述               |
|--------------|------------------|
| geoip_cn.txt | mosdns中定义的国内ip列表 |

## 七.该项目仅为个人测试使用，如有侵权请联系，会及时调整