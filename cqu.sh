#!/bin/bash

# 登陆

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

# 默认使用 PC 端登录
callback="dr1004"
name="" # 输入你的学号
password="" # 输入你的密码

# 检查是否传入了设备类型参数
if [ -n "$2" ]; then
    if [ "$2" == "1" ]; then
        callback="dr1005"
    fi
fi

# 定义 API URL
api_url="https://login.cqu.edu.cn:802/eportal/portal/login?callback=${callback}&login_method=1&user_account=%2C0%2C${name}&user_password=${password}&wlan_user_ip=180.85.207.172&wlan_user_ipv6=&wlan_user_mac=ffffffffffff&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.2&terminal_type=1&lang=zh-cn&v=6551&lang=zh"

# 使用 curl 调用 API 并输出返回值
response=$(curl -s "$api_url")

# 输出返回值
echo "$response"

# 检查是否传入了 OpenVPN 配置文件路径
if [ -n "$1" ]; then
    # 检查是否安装了 openvpn
    if ! command -v openvpn &> /dev/null; then
        echo "openvpn 未安装，正在安装 openvpn..."
        sudo apt update
        sudo apt install -y openvpn
        if ! command -v openvpn &> /dev/null; then
            echo "安装 openvpn 失败，请手动安装后重试。"
            exit 1
        fi
        echo "openvpn 安装成功！"
    fi

    # 检查 OpenVPN 配置文件是否存在
    if [ -f "$1" ]; then
        echo "正在连接 OpenVPN..."
        sudo openvpn --config "$1"
    else
        echo "错误：OpenVPN 配置文件 $1 不存在。"
        exit 1
    fi
fi
