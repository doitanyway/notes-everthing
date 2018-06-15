# iptables


## centos 6
### 打开某些端口访问权限

* 修改``/etc/sysconfig/iptables``文件，添加入下内容

```
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6479 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6579 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 26379 -j ACCEPT
```

* 执行命令``service iptables restart``,重启iptables生效新的规则；

### 向某些IP打开某些端口的访问权限

```
-N whitelist
-A whitelist -s 192.168.1.171 -j ACCEPT
-A whitelist -s 192.168.1.244 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j whitelist
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6479 -j whitelist
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6579 -j whitelist
-A INPUT -m state --state NEW -m tcp -p tcp --dport 26379 -j whitelist
```

* 执行命令``service iptables restart``,重启iptables生效新的规则；


## centos 7

### firewalld的基本使用
启动： systemctl start firewalld  
查看状态： systemctl status firewalld   
停止： systemctl disable firewalld  
禁用： systemctl stop firewalld  
 
### systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。  
启动一个服务：systemctl start firewalld.service  
关闭一个服务：systemctl stop firewalld.service  
重启一个服务：systemctl restart firewalld.service  
显示一个服务的状态：systemctl status firewalld.service  
在开机时启用一个服务：systemctl enable firewalld.service  
在开机时禁用一个服务：systemctl disable firewalld.service  
查看服务是否开机启动：systemctl is-enabled firewalld.service  
查看已启动的服务列表：systemctl list-unit-files|grep enabled  
查看启动失败的服务列表：systemctl --failed  

### 配置firewalld-cmd

查看版本： firewall-cmd --version  
查看帮助： firewall-cmd --help  
显示状态： firewall-cmd --state  
查看所有打开的端口： firewall-cmd --zone=public --list-ports  
更新防火墙规则： firewall-cmd --reload  
查看区域信息:  firewall-cmd --get-active-zones  
查看指定接口所属区域： firewall-cmd --get-zone-of-interface=eth0  
拒绝所有包：firewall-cmd --panic-on  
取消拒绝状态： firewall-cmd --panic-off  
查看是否拒绝： firewall-cmd --query-panic  
 
### 怎么开启一个端口呢

添加  
firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）  
重新载入  
firewall-cmd --reload  
查看  
firewall-cmd --zone=public --query-port=80/tcp  
删除  
firewall-cmd --zone=public --remove-port=80/tcp --permanent  