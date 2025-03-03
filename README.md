这是用脚本实现登陆重大校园网 v0.2

~~并且在里面添加了连接 `openvpn` 的操作~~

现在将登陆校园网的 `API` 和 使用`OpenVPN` 远程连接分成两个文件

- **cqu.sh** `API` 登陆校园网

    连接时候的帐号密码在 `cqu.sh` 文件中的 `13-14` 行
    ```BASH
    name="" # 输入你的学号
    password="" # 输入你的密码
    ```

- **out.sh** `API` 退出登陆

- **vpn.sh** 连接 `OpenVPN`

  如果你没有需求就不用下载 `vpn.sh`
