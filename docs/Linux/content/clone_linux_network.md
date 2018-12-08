# 克隆LINUX系统

由于克隆虚拟机，vmware只是修改了虚拟机的名字等信息，并没有修改虚拟硬盘中的任何信息，导致克隆后网卡的MAC地址和操作系统中记录的mac地址不符，导致eth0启动不起来。操作系统记录了一个新网卡的添加，新网卡的名字eth1，mac地址就是vmware分配给的新的mac地址 
 
解决方法： 
 
修改 ``/etc/udev/rules.d/70-persistent-net.rules`` 文件 
删除掉 关于 eth0 的信息。修改 第二条 eth1 的网卡的名字为 eth0. 
 
修改 ``/etc/sysconfig/network-scripts/ifcfg-eth0`` 中mac地址为 ``/etc/udev/rules.d/70-persistent-net.rules`` 修改后的eth0的mac地址。

给CentOS虚拟机配置固定ip

``vim /etc/sysconfig/network-scripts/ifcfg-eth0``
以下是网卡eth0的信息

```
DEVICE="eth0"
#BOOTPROTO="dhcp"
BOOTPROTO="static"
HWADDR="00:0c:29:74:0b:15"
IPADDR="192.168.9.130"
GATEWAY="192.168.9.1"
NETMASK="255.255.255.0"
NETWORK="192.168.9.0"
NM_CONTROLLED="yes"
ONBOOT="yes"
TYPE="Ethernet"
UUID="3d8d42e3-c409-4f19-9553-aac34782711c" 
```