## centos 7开机启动

### 前言

本文介绍如何在centos 7中设置一个自动自动服务。


### 操作步骤

* 准备操作脚本(/root/pin_test.sh)，操作脚本负责开启(start)、关闭(stop)、重启服务(restart)，具体服务器这里用一个ping 命令做示范；

```bash
#!/bin/bash

cmd=$1

function stop(){
  echo 'stop cmd'
  ps -ef | grep ping | grep -v grep | awk '{print $2}'|xargs kill -9
  return ;
}

function start(){
  echo 'start cmd'
  nohup ping www.baidu.com > /root/log.log 2>&1 &
  return ;
}

function restart(){
  echo 'restart cmd'
  stop ;
  sleep 3s;
  start ;
  return ;
}

case $cmd in
  start)
    start ;
    ;;
  stop)
    stop ;
    ;;
  restart)
    restart;
    ;;
  *)
    echo 'unkonow cmd'
  ;;
esac
```

* 配置服务器文件,/lib/systemd/system/pin.service 

```ini
[Unit]  
Description=ping test
After=network.target  
   
[Service]  
Type=forking  
ExecStart=/root/pin_test.sh  start  
ExecReload=/root/pin_test.sh  restart  
ExecStop=/root/pin_test.sh  stop  
PrivateTmp=true  
   
[Install]  
WantedBy=multi-user.target
```


* 设置开机启动，并且启动服务器

```
systemctl enable pin.service  
systemctl start pin.service  
```


### 补充说明 依赖关系

[Unit]段可以加配置设置一些依赖关系

* 启动顺序
  * After=network.target sshd-keygen.service  ，定义文件的服务在这2个服务之后启动
  * Before=sshd-keygen.service ，定义文件的服务需要在sshd-keygen服务器之后启动；
* 依赖关系
  * Wants=sshd-keygen.service  ， 弱依赖关系，如果"sshd-keygen.service"启动失败或停止运行，不影响sshd.service继续执行。
  * Requires=sshd-keygen.service，强依赖关系，如果该服务启动失败或异常退出，那么sshd.service也必须退出。


  
