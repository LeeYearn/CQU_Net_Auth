#!/bin/bash

# 退出登陆

# 检测是否安装了 curl
if ! command -v curl &> /dev/null; then
    echo "curl 未安装，正在安装 curl..."
    sudo apt update
    sudo apt install -y curl
    if ! command -v curl &> /dev/null; then
        echo "安装 curl 失败，请手动安装后重试。"
        exit 1
    fi
    echo "curl 安装成功！"
    clear  # 安装完成后清空终端屏幕
fi

# 定义注销 API URL
logout_url="https://login.cqu.edu.cn:802/eportal/portal/logout?callback=dr1004&login_method=1&user_account=drcom&user_password=123&ac_logout=1&register_mode=1&wlan_user_ip=180.85.207.172&wlan_user_ipv6=&wlan_vlan_id=0&wlan_user_mac=ffffffffffff&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.2&v=4584&lang=zh"

# 使用 curl 调用注销 API 并输出返回值
response=$(curl -s "$logout_url")

# 输出返回值
echo "$response"
