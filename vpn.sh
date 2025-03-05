#!/bin/bash

# 检查是否提供了 OpenVPN 配置文件
if [ -z "$1" ]; then
    echo "错误：请提供 OpenVPN 配置文件路径"
    exit 1
fi

# 先调用 out.sh 进行认证注销
echo "正在进行 CQU 注销..."
bash "$(dirname "$0")/out.sh"

# 再调用 cqu.sh 进行认证登录
echo "正在进行 CQU 认证..."
bash "$(dirname "$0")/cqu.sh"

# 检测是否安装了 openvpn
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
