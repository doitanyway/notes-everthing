# ssh免密登陆

## 前言

本文介绍如何在centos下制作ssh免密登陆。  
配置环境入下：

|主机名字|主机ip|说明|
|--|--|--|
|client|192.168.1.171|客户端，需要登陆其他主机的主机|
|server|192.168.1.149|服务器，需要被登陆的主机|

## 操作步骤

* 登陆client，生成密钥
```
# ls ~/.ssh/          # 如果文件夹不存在则创建 mkdir ~/.ssh/
# chmod 755 ~/.ssh/
# cd ~/.ssh/
# ssh-keygen -t rsa   # 该命令之后一直回车
 ...
# ls
id_rsa		id_rsa.pub	known_hosts	y		y.pub
```

* 上传工钥文件``id_rsa.pub``到server
```
scp id_rsa.pub root@192.168.1.147:/root/.ssh/   # 如果服务器没有.ssh文件则可以登陆创建
```

* 登陆server，生成工钥文件，修改文件权限；
```
# ssh root@192.168.1.147        # client 上运行改命令登陆server，需输入server密码
# cd .ssh/
# cat id_rsa.pub >> authorized_keys
# chmod 700 ~/.ssh/
# chmod 600 ~/.ssh/*
# systemctl restart sshd.service
```