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


* 系统初始化,执行[脚本](initsys.sh)初始化系统:  

```bash 
# curl -s http://XXX.com/xx/xx.sh | bash -s arg1 arg2
# curl http://XXX.com/xx/xx.sh | bash


```

