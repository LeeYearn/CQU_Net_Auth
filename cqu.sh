#!/bin/bash

# 自动检测网卡并获取 IPv4 地址
ip=$(ip -4 -o addr show | awk '!/ lo/ {print $4}' | cut -d/ -f1 | head -n 1)

# 检查是否成功获取 IP
if [ -z "$ip" ]; then
    echo "无法获取 IP 地址，请检查网络连接。"
    exit 1
fi

# 默认使用 PC 端登录
callback="dr1004"
name="" # 输入你的学号
password="" # 输入你的密码

# 检查是否传入了设备类型参数
if [ "$#" -ge 1 ] && [ "$1" == "1" ]; then
    callback="dr1005"
fi

# 定义 API URL
api_url="https://login.cqu.edu.cn:802/eportal/portal/login?callback=${callback}&login_method=1&user_account=%2C0%2C${name}&user_password=${password}&wlan_user_ip=${ip}&wlan_user_ipv6=&wlan_user_mac=ffffffffffff&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.2&terminal_type=1&lang=zh-cn&v=6551&lang=zh"

# 使用 curl 调用 API 并输出返回值
response=$(curl -s "$api_url")

# 解析返回的 JSON 数据，只提取 msg 字段
msg=$(echo "$response" | grep -oP '"msg":"\K[^"]+')

# 输出处理后的消息
if [[ "$msg" == "Portal协议认证成功！" ]]; then
    echo "协议认证成功! 当前IP: $ip"
elif [[ "$msg" == IP:* ]]; then
    echo "$msg"
else
    echo "未知返回信息: $msg"
fi