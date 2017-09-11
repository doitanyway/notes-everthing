# 页面配置

## 创建一个HOST

* 点击``configuration``->``hosts``->``create hosts``开始创建host

* 如下图，填写``Host name``,``Agent interfaces``,``New group``(也可选择已有group，根据实际情况)

![](assets/2017-09-11-17-25-45.png)

* 点击add添加；

## 监控memory

### 新建memory相关items


* ``configuration``->``hosts``选中列表中host的item列；
* 点击``create item``

## item keys

https://www.zabbix.com/documentation/3.4/manual/config/items/itemtypes/zabbix_agent

vm.memory.size[total]   


## zabbix-get

服务器端可以安装zabbix-get可以更好的调试程序。
```
yum install zabbix-get.x86_64
```

