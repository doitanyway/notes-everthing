# 搭建本地YUM源安装ansible

## 场景介绍

在企业环境下我们通常需要离线安装文件，在联网情况下一个yum命令即可完成安装，但是离线情况下安装确很复杂，为了解决该问题，我们可以选择本地yum源的解决方案。在使用本地yum源时需要收集相关依赖文件，本文介绍如何收集对应软件的依赖文件。

* 使用yum-utils下载依赖包
* 使用createrepo创建本地库


## 操作步骤 

### 下载离线安装包

准备一台联网电脑，安装与目标电脑使用相同镜像的os服务器，使用yumdownloader工具下载安装包及其相关依赖包(本文以安装ansible为例)  

```bash 
# 使用root执行如下命令  
cd ~
# 安装工具yum-utils   
yum install yum-utils -y
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
#  创建目标文件夹,下载依赖包到目标文件夹 
mkdir -p /root/mypackages
yumdownloader --resolve --destdir /root/mypackages/ ansible
yumdownloader --resolve --destdir /root/mypackages/ createrepo

tar -czvf ansible.tar.gz ./mypackages

```

###  安装

* 下载包，并上传上一个步骤生成包到内网需要安装该软件的目标机上 


```bash 
mkdir -p /data/
tar -xzvf ansible.tar.gz -C /data/

# 安装createrepo
cd /data/mypackages
# rpm -ivh deltarpm-3.6-3.el7.x86_64.rpm 
rpm -ivh python-deltarpm-3.6-3.el7.x86_64.rpm
rpm -ivh createrepo-0.9.9-28.el7.noarch.rpm 


# 制作离线源,成功执行后能在/data/ansible_packages看到新增了一个repodata目录：
createrepo /data/mypackages



# 新增yum文件/etc/yum.repos.d/ansible.repo  ，如下注释2行是删除掉原有源
# mkdir /root/repo_bak
# mv /etc/yum.repos.d/*.repo  /root/repo_bak
cat  << 'EOF' > /etc/yum.repos.d/ansible.repo
[ansible]
name=ansible
baseurl=file:///data/mypackages
gpgcheck=0
enabled=1
EOF

```

* 测试安装  

```bash 
# 清理缓存更新 
yum clean all 
yum makecache

# 更新版本
yum repolist
yum list|grep ansible 
# 安装ansible 
yum install ansible -y
# 验证ansible是否安装成功
ansible --version

```


## 补充说明 

如果还缺少部分的rpm包，可以到[centos官网在线下载](http://mirror.centos.org/centos/)