
## 挂载本地yum源

```bash 
# 假设镜像目录为 /root/CentOS-7-x86_64-DVD-1810.iso
mkdir -p /data/centos
mount -t iso9660 /root/CentOS-7-x86_64-DVD-1810.iso /data/centos

# 备份默认源
mkdir /root/centos-yum.bak
mv /etc/yum.repos.d/* /root/centos-yum.bak/

# 源文件配置(可选，如果配置本地源头) 
cat << EOF >/etc/yum.repos.d/local.repo
[local]
name=local
baseurl=file:///data/centos
enabled=1
gpgcheck=0
EOF

# 清除缓存
yum clean all 
yum makecache
# 列出了yum包
 yum list  java
# 查看yum仓库列表,查看会返回有local的源
yum repolist

# 开机自动挂载iso文件  
echo "/root/CentOS-7-x86_64-DVD-1810.iso /opt/centos iso9660 loop 0 0" >> /etc/fstab

# 取消挂载 
# 删除配置文件  /etc/fstab
# umount /opt/centos 

```
