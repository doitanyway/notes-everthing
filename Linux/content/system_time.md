# 系统时间设置

## 同步
安装时间同步工具。
```
yum install ntpdate 
```
同步时间
```
ntpdate -u ntp.api.bz
```
其他时间同步服务器； 
美国：time.nist.gov   
复旦：ntp.fudan.edu.cn   
微软公司授时主机(美国) ：time.windows.com   
台警大授时中心(台湾)：asia.pool.ntp.org  

## 写hwclock 
查看时间
```
hwclock -r
```
写时间：
```
hwclock -w
```


