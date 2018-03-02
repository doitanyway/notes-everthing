# df查看磁盘提示“未处理文件系统”的解决办法

在LINUX系统中，用df -h查看会出现如下错误：
```
[root@localhost ~]# df -h
df: 未处理文件系统
```

解决的办法是：

```
[root@localhost ~]# mv /etc/mtab /etc/mtab.old
```
```
[root@localhost ~]# ln -s /proc/mounts /etc/mtab
```