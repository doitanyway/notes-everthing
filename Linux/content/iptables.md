# iptables

## 打开某些端口访问权限

* 修改``/etc/sysconfig/iptables``文件，添加入下内容

```
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6479 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6579 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 26379 -j ACCEPT
```

* 执行命令``service iptables restart``,重启iptables生效新的规则；

## 向某些IP打开某些端口的访问权限

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
