# 本项目用于拉取gfwlist的域名并转换

## 一.转换成dnsmasq格式

```sh
cd dnsmasq && sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf >/dev/null 2>&1
```

## 二.转换成smartdns格式，后面传入smartdns的国外解析分组名，不传默认为gfwlist

```sh
bash smartdns.sh $group_name
```

## 三.转换成mosdns格式

```sh
bash mosdns.sh
```

## 四.dnsmasq文件夹说明

| 文件名                                                                                                         | 描述                    |
|-------------------------------------------------------------------------------------------------------------|-----------------------|
| [dnsmasq_gfwlist.conf](https://github.com/liu88010988/gfw2dnsmasq/blob/master/dnsmasq/dnsmasq_gfwlist.conf) | gfw域名对应dnsmasq格式的域名列表 |

## 五.domain文件夹说明

| 文件名                                                                                                                            | 描述             |
|--------------------------------------------------------------------------------------------------------------------------------|----------------|
| [cdn_domain_list.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/cdn_domain_list.txt)                       | cdn域名列表        |
| [exclude_domain.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/exclude_domain.txt)                         | 国外代理域名列表中排除的域名 |
| [geosite.dat](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite.dat)                                       | geosite全量原始数据  |
| [geosite_apple-cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_apple-cn.txt)                     | 国内apple域名列表    |
| [geosite_category-games@cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_category-games%40cn.txt) | 国内steam域名列表    |
| [geosite_cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_cn.txt)                                 | 国内域名列表         |
| [geosite_geolocation-!cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_geolocation-!cn.txt)       | 国外代理域名列表       |
| [geosite_gfw.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_gfw.txt)                               | 国外gwf域名列表      |
| [geosite_google-cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_google-cn.txt)                   | 国内google域名列表   |
| [geosite_private.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_private.txt)                       | 国内私有域名列表       |
| [geosite_tld-cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/domain/geosite_tld-cn.txt)                         | 国内私有域名列表       |

## 六.hosts文件夹说明

| 文件名       | 描述            |
|-----------|---------------|
| hosts.txt | mosdns自定义域名列表 |

## 七.ip文件夹说明

| 文件名                                                                                              | 描述          |
|--------------------------------------------------------------------------------------------------|-------------|
| [geoip.dat](https://github.com/liu88010988/gfw2dnsmasq/blob/master/ip/geoip.dat)                 | geoip全量原始数据 |
| [geoip_cn.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/ip/geoip_cn.txt)           | 国内ip列表      |
| [geoip_private.txt](https://github.com/liu88010988/gfw2dnsmasq/blob/master/ip/geoip_private.txt) | 私有ip列表      |

## 八.该项目仅为个人测试使用，如有侵权请联系，会及时调整