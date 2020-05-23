#!/bin/bash 

# 关闭防火墙   
systemctl stop firewalld.service
systemctl disable firewalld.service
sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config 
setenforce 0

# 设置HOST  
cat >> /etc/hosts << EOF
192.168.90.11 mdw
192.168.90.12 sdw2
EOF

# 配置ssh  
chmod +x /etc/rc.d/rc.local
grubby --update-kernel=ALL --args="elevator=deadline"
grubby --info=ALL
grubby --update-kernel=ALL --args="transparent_hugepage=never"
sed -i 's@#RemoveIPC=no@RemoveIPC=no@g' /etc/systemd/logind.conf
systemctl restart systemd-logind.service

# 配置sysctl.conf  
###modify sysctl.conf###
cat >>/etc/sysctl.conf<< EOF
####Greeplum env####
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.ip_local_port_range = 1024 65000
net.core.somaxconn = 65535
net.core.netdev_max_backlog = 65535
net.ipv4.tcp_max_orphans = 16384
kernel.shmall = $(expr $(getconf _PHYS_PAGES) / 2)
kernel.shmmax = $(expr $(getconf _PHYS_PAGES) / 2 \* $(getconf PAGE_SIZE))
kernel.shmmni = 4096
kernel.sem = 500 2048000 200 40960
vm.overcommit_memory = 2
vm.overcommit_ratio = 90
vm.swappiness=0
EOF

free_size=`free -g|grep Mem|awk '{print $2}'`
if [ $free_size -lt 60 ];then
        echo "vm.dirty_background_ratio = 3" >> /etc/sysctl.conf
        echo "vm.dirty_ratio = 10" >> /etc/sysctl.conf
else
        echo "vm.dirty_background_ratio = 0" >> /etc/sysctl.conf
        echo "vm.dirty_ratio = 0" >> /etc/sysctl.conf
        echo "vm.dirty_background_bytes = 1610612736 " >> /etc/sysctl.conf
        echo "vm.dirty_bytes = 4294967296" >> /etc/sysctl.conf
fi
awk 'BEGIIN {OFMT = "%.0f";} /MemTotal/ {print "vm.min_free_kbytes =", $2 * .03}' /proc/meminfo >>/etc/sysctl.conf
###modify limits.conf###  
cp /etc/security/limits.conf /etc/security/limits.conf.bak
sed -i '/^*/d' /etc/security/limits.conf
cat >>/etc/security/limits.conf<< EOF
*               soft    nofile          655360
*               hard    nofile          655360
*               soft    nproc           655360
*               hard    nproc           655360
*               soft    stack           unlimited
*               hard    stack           unlimited
EOF

cp /etc/security/limits.d/20-nproc.conf /etc/security/limits.d/20-nproc.conf.bak
sed -i '/^*/d' /etc/security/limits.d/20-nproc.conf
echo "*               soft    nproc           655360" >>/etc/security/limits.d/20-nproc.conf

###modify sshd###
echo "MaxStartups 200" >>/etc/ssh/sshd_config
echo "MaxSessions 200" >>/etc/ssh/sshd_config
systemctl restart sshd.service

###create user###
groupadd gpadmin
useradd gpadmin -r -m -g gpadmin
echo 'bigData@123' | passwd --stdin gpadmin
echo 'gpadmin ALL = (ALL) ALL' >>/etc/sudoers

