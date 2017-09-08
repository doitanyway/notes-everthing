# 安装

## 安装rpm包

安装带有可用的mysql5系列社区版资源的rpm包

```
# rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
获取http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
准备中...                          ################################# [100%]
正在升级/安装...
   1:mysql-community-release-el7-5    ################################# [100%]
```

这个时候查看当前可用的mysql安装资源：
```
# yum repolist enabled | grep "mysql.*-community.*"
mysql-connectors-community/x86_64 MySQL Connectors Community                  17
mysql-tools-community/x86_64      MySQL Tools Community                       31
mysql56-community/x86_64          MySQL 5.6 Community Server                 199
```

## yum安装

```
# yum -y install mysql-community-server
...
```

## 安装完的配置

* 加入开机启动
```
# systemctl enable mysqld
```

* 启动mysql服务进程
```
# systemctl start mysqld
```

* 重置密码
```
# mysql_secure_installation
```


