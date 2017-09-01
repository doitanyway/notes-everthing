# logrotate日志管理 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [作用](#作用)
* [安装](#安装)
* [使用](#使用)
* [配置案列](#配置案列)
	* [样例1](#样例1)
	* [样例2](#样例2)
	* [样例3](#样例3)
	* [样例4](#样例4)
* [故障排除](#故障排除)
	* [手动调用](#手动调用)
	* [演练](#演练)
	* [强制轮询](#强制轮询)
* [Logrotate的记录日志](#logrotate的记录日志)
* [Logrotate定时任务](#logrotate定时任务)
* [其他](#其他)

<!-- /code_chunk_output -->



## 作用
日志文件包含了关于系统中发生的事件的有用信息，在排障过程中或者系统性能分析时经常被用到。对于忙碌的服务器，日志文件大小会增长极快，服务器会很快消耗磁盘空间，这成了个问题。除此之外，处理一个单个的庞大日志文件也常常是件十分棘手的事。  
logrotate是个十分有用的工具，它可以自动对日志进行截断（或轮循）、压缩以及删除旧的日志文件。例如，你可以设置logrotate，让/var/log/foo日志文件每30天轮循，并删除超过6个月的日志。配置完后，logrotate的运作完全自动化，不必进行任何进一步的人为干预。另外，旧日志也可以通过电子邮件发送，不过该选项超出了本教程的讨论范围。

## 安装
主流Linux发行版上都默认安装有logrotate包，如果出于某种原因，logrotate没有出现在里头，可以使用yum安装
```
yum -y install logrotate crontabs 
```

## 使用
logrotate的配置文件是/etc/logrotate.conf，通常不需要对它进行修改。日志文件的轮循设置在独立的配置文件中，把它（们）放在/etc/logrotate.d/目录下,配置完之后不用重启自动生效。

## 配置案列

### 样例1
创建一个10MB的日志文件/var/log/log-file，使用logrotate管理日志文件
```
# touch /var/log/log-file
# head -c 10M < /dev/urandom > /var/log/log-file 
```
由于现在日志文件已经准备好，我们将配置logrotate来轮循该日志文件。让我们为该文件创建一个配置文件。
```
# vim /etc/logrotate.d/log-file 
```

```
/var/log/log-file {
    monthly
    rotate 5
    compress
    delaycompress
    missingok
    notifempty
    create 644 root root
    postrotate
        /usr/bin/killall -HUP rsyslogd
    endscript
}
```

* monthly: 日志文件将按月轮循。其它可用值为‘daily’，‘weekly’或者‘yearly’。
* rotate 5: 一次将存储5个归档日志。对于第六个归档，时间最久的归档将被删除。
* compress: 在轮循任务完成后，已轮循的归档将使用gzip进行压缩。
* delaycompress: 总是与compress选项一起用，delaycompress选项指示logrotate不要将最近的归档压缩，压缩将在下一次轮循周期进行。这在你或任何软件仍然需要读取最新归档时很有用。
* missingok: 在日志轮循期间，任何错误将被忽略，例如“文件无法找到”之类的错误。
* notifempty: 如果日志文件为空，轮循不会进行。
* create 644 root root: 以指定的权限创建全新的日志文件，同时logrotate也会重命名原始日志文件。
* postrotate/endscript: 在所有其它指令完成后，postrotate和endscript里面指定的命令将被执行。在这种情况下，rsyslogd 进程将立即再次读取其配置并继续运行。

### 样例2
在本例中，我们只想要轮循一个日志文件，然而日志文件大小可以增长到50MB。

```
# vim /etc/logrotate.d/log-file 
```

```
/var/log/log-file {
    size=50M
    rotate 5
    create 644 root root
    postrotate
        /usr/bin/killall -HUP rsyslogd
    endscript
}
```

### 样例3
我们想要让旧日志文件以创建日期命名，这可以通过添加dateext常熟实现。

```
# vim /etc/logrotate.d/log-file 
```
```
/var/log/log-file {
    monthly
    rotate 5
    dateext
    create 644 root root
    postrotate
        /usr/bin/killall -HUP rsyslogd
    endscript
}
```


### 样例4
保存当前正在打开的日志，按每天保存，保存7个备份，按日期修改文件名，压缩保存（延迟压缩），忽略错误，空文件不处理。
``
vim /usr/local/tomcat_road/logs/catalina.out
``
```
/usr/local/tomcat_road/logs/catalina.out
{
    copytruncate
    daily
    rotate 7
    compress
    missingok
    notifempty
    dateext
}
```
注意：delaycompress还在考虑；

## 故障排除
这里提供了一些logrotate设置的排障提示。

### 手动调用
logrotate可以在任何时候从命令行手动调用。
要调用为/etc/lograte.d/下配置的所有日志调用logrotate：
```
# logrotate /etc/logrotate.conf 
```
要为某个特定的配置调用logrotate：
```
# logrotate /etc/logrotate.d/log-file 
```
### 演练
排障过程中的最佳选择是使用‘-d’选项以预演方式运行logrotate。要进行验证，不用实际轮循任何日志文件，可以模拟演练日志轮循并显示其输出。
```
# logrotate -d /etc/logrotate.d/log-file 
```

### 强制轮询
即使轮循条件没有满足，我们也可以通过使用‘-f’选项来强制logrotate轮循日志文件，‘-v’参数提供了详细的输出。
```
[root@bogon logrotate.d]# logrotate -vf tomcat
```

```
[root@bogon logrotate.d]# logrotate -vf tomcat 
reading config file tomcat
reading config info for /usr/local/tomcat_road/logs/catalina.out 

Handling 1 logs

rotating pattern: /usr/local/tomcat_road/logs/catalina.out 
 forced from command line (7 rotations)
empty log files are not rotated, old logs are removed
considering log /usr/local/tomcat_road/logs/catalina.out
  log needs rotating
rotating log /usr/local/tomcat_road/logs/catalina.out, log->rotateCount is 7
dateext suffix '-20170902'
glob pattern '-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
glob finding old rotated logs failed
copying /usr/local/tomcat_road/logs/catalina.out to /usr/local/tomcat_road/logs/catalina.out-20170902
truncating /usr/local/tomcat_road/logs/catalina.out
compressing log with: /bin/gzip
```




## Logrotate的记录日志
logrotate自身的日志通常存放于/var/lib/logrotate/status目录。

##  Logrotate定时任务
logrotate需要的cron任务应该在安装时就自动创建了，我把cron文件的内容贴出来，以供大家参考。

```
# cat /etc/cron.daily/logrotate 
```
```
#!/bin/sh

/usr/sbin/logrotate /etc/logrotate.conf
EXITVALUE=$?
if [ $EXITVALUE != 0 ]; then
    /usr/bin/logger -t logrotate "ALERT exited abnormally with [$EXITVALUE]"
fi
exit 0
```



## 其他
gz文件解压与压缩
gzip –c filename > filename.gz
gunzip –c filename.gz > filename  

