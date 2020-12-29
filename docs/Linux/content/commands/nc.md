# nc 


```bash 
# nc -l 80
# Linux 使用NC命令监听本地端口
# 1.临时监听TCP端口
nc -l port
# 2.永久监听TCP端口
nc -lk port
# 3.临时监听UDP
nc -lu port
# 4.永久监听UDP
nc -luk port

# 5.测试TCP端口
nc -vz ip tcp-port
# 6.测试UDP
nc -uvz ip udp-port

# 举个例子
# 服务器a上创建监听tcp端口（192.168.2.1）
nc -l 8080
# 服务器b上测试端口是否畅通（192.168.2.2）
nc -vz 192.168.2.1 8080
# 或者
curl 192.168.2.1:8080
# 或者
wget 192.168.2.1:8080
# 注意这些命令需要安装才能使用
```