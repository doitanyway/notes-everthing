# ssh-copy-id


ssh-copy-id命令可以把本地主机的公钥复制到远程主机的authorized_keys文件上，ssh-copy-id命令也会给远程主机的用户主目录（home）和~/.ssh, 和~/.ssh/authorized_keys设置合适的权限。

# 语法

ssh-copy-id [-i [identity_file]] [user@]machine

-i：指定公钥文件


## 例
1、把本地的ssh公钥文件安装到远程主机对应的账户下：

```
ssh-copy-id user@server
ssh-copy-id -i ~/.ssh/id_rsa.pub user@server
```