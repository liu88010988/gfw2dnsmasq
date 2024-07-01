# 本项目用于拉取gfwlist的域名并转换
## 转换成dnsmasq格式
```sh
sh dnsmasq_gfwlist.sh -o dnsmasq_gfwlist.conf
```
## 转换成smartdns格式,后面传入smartdns的国外解析分组名，不传默认为gfwlist
```sh
sh smartdns_gfwlist.sh $group_name
```
## 自定义的额外gfw域名可以加到domain/additional_domain.txt中
## 自定义的非gfw域名可以加到domain/exclude_domain.txt中
## 该项目仅为个人测试使用，如有侵权请联系，会及时调整