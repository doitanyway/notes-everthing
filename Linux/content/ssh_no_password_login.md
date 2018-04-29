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

* 上传密钥到服务器
```
ssh-copy-id  root@192.168.1.147
```


> 完成上诉步骤之后，在服务器的/root/.ssh/authorized_keys目录下将会有如下文件。
