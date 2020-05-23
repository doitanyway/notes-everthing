# greenplum安装


## 简介

本文介绍如何在centos 7上安装greenplum。

* 软件版本：  
  * CentOS Linux release 7.5.1804
  * greenplum-db-6.4.0-rhel7-x86_64

* 安装架构 

|主机|ip|安装内容|
|--|--|--|
|m1|192.168.90.11|master host,segment host|
|m2|192.168.90.12|segment host|

* 对应安装包请到百度网盘下载：  

链接:https://pan.baidu.com/s/1_WZFm9jwlTwh9nSvA-ClLA  密码:vv7u


## 安装步骤   


* 系统初始化,执行[脚本](initsys.sh)初始化系统:  （m1、m2上分别root执行）

```bash 
# 初始化系统
curl https://gitee.com/nickqiu/notes-everything/raw/master/docs/greenplum/docs/initsys.sh | bash 

# curl 传递参数方法
# curl -s http://XXX.com/xx/xx.sh | bash -s arg1 arg2
```


* 上传软件包到目录 ``~``,执行如下脚本：  （m1、m2上分别root执行）
```bash 
cd ~
yum install -y apr
yum install -y apr-util
yum install -y net-tools 
yum install -y zip
yum install -y perl
yum install -y libyaml
# 查询,卸载,可能需要协助
rpm -qa krb5-libs
# krb5-libs-1.15.1-19.el7.x86_64
rpm -e --nodeps krb5-libs-1.15.1-19.el7.x86_64
rpm -ivh        krb5-libs-1.15.1-18.el7.x86_64.rpm
yum install -y krb5-devel

rpm -ivh greenplum-db-6.4.0-rhel7-x86_64.rpm

# /data替换成为大的目录
data_dir=/data
mkdir -p /home/gpadmin/gpconfigs
mkdir -p $data_dir/master
mkdir -p $data_dir/primary



# 配置hostlist文件记录所有节点    
cat >/home/gpadmin/gpconfigs/hostfile_gpinitsystem<< EOF
m1
m2
EOF

# seg_hosts文件只记录segment节点     
cat >/home/gpadmin/gpconfigs/seg_hosts<< EOF
m1
m2
EOF

# 编辑gp初始化文件 
cat > /home/gpadmin/gpconfigs/gpinitsystem_config<< EOF
ARRAY_NAME="Greenplum Data Platform"
SEG_PREFIX=gpseg
PORT_BASE=6000 
# 数据目录
declare -a DATA_DIRECTORY=($data_dir/primary $data_dir/primary)
# 主节点
MASTER_HOSTNAME=m1
# 主节点数据目录
MASTER_DIRECTORY=$data_dir/master 
MASTER_PORT=5432 
TRUSTED SHELL=ssh
CHECK_POINT_SEGMENTS=8
ENCODING=UNICODE
DATABASE_NAME=gp_sydb
# 所有segment定义节点  
MACHINE_LIST_FILE=/home/gpadmin/gpconfigs/seg_hosts
EOF

source /usr/local/greenplum-db/greenplum_path.sh
chown -R gpadmin:gpadmin /usr/local/greenplum*
chown -R gpadmin:gpadmin $data_dir
chown -R gpadmin:gpadmin /home/gpadmin
```
