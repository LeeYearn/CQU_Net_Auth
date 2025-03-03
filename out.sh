#!/bin/bash

# 退出登陆

# 自动检测网卡并获取 IPv4 地址
ip=$(ip -4 -o addr show | awk '!/ lo/ {print $4}' | cut -d/ -f1 | head -n 1)

# 检查是否成功获取 IP
if [ -z "$ip" ]; then
    echo "无法获取 IP 地址，请检查网络连接。"
    exit 1
fi

# echo "当前IP：$ip"

# 定义注销 API URL
logout_url="https://login.cqu.edu.cn:802/eportal/portal/logout?callback=dr1003&login_method=1&user_account=drcom&user_password=123&ac_logout=1&register_mode=1&wlan_user_ip=${ip}&wlan_user_ipv6=%3A%3A&wlan_vlan_id=1&wlan_user_mac=ffffffffffff&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.2&v=3689&lang=zh"

# 使用 curl 调用注销 API 并输出返回值
response=$(curl -s "$logout_url")

# 解析返回的 JSON 数据，只提取 msg 字段
msg=$(echo "$response" | grep -oP '"msg":"\K[^"]+')

# 输出处理后的消息
if [[ "$msg" == "Radius注销成功！" ]]; then
    echo "注销成功!"
elif [[ "$msg" == "Radius注销失败！" ]]; then
    echo "注销失败!"
else
    echo "未知返回信息: $msg"
fi

