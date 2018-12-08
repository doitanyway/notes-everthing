# 启动脚本路径
将写好的autostart.sh脚本移动到/etc/rc.d/init.d/目录下
```
cd /etc/rc.d/init.d/
```
给脚本赋可执行权限
```
chmod +x redis_6379
```
将服务脚本加入到系统启动队列
```
chkconfig redis_6379  #服务脚本加入到系统启动队列
chkconfig --list  redis_6379#检查 oracle服务是否已经生效
```

# redis_6379

```
#!/bin/sh
#chkconfig:345 86 15
#description:redis_6379 service

. /etc/init.d/functions
PR_ID=`ps -ef|grep redis|grep -v redis_6379|grep -v grep|grep 6379 |awk '{print $2}'`
REDIS_ID=`ps -ef|grep redis|grep -v redis_6379|grep 6379|wc -l`
start() {
  if [ $REDIS_ID -eq 1 ];then
     echo "redis_6379 is running"
     exit
  fi
     echo "REDIS is start"
  /usr/local/bin/redis-server --include /usr/local/redis_cluster/master_6379/redis.conf > /dev/null > 1 > /etc/redis.log &
  /usr/local/bin/redis-server /usr/local/redis_cluster/master_6379/sentinel.conf  --sentinel > /dev/null > 1 > /etc/redis.log &
  if [ $? -eq 0 ];then
    action "redis_6379 started" /bin/true
  else
    action "redis_6379 started" /bin/false
  fi
}
stop() {
  if [ $REDIS_ID -eq 0 ];then
    echo "redis_6379 stopped"
    exit 1
  fi
  echo "REDIS is stopped....."
  kill -9 $PR_ID  2>&1 >/dev/null
  if [ $? -eq 0 ];then
    action "redis_6379 stopped" /bin/true
  else
    action "redis_6379 stopped" /bin/false
  fi
}
restart() {
   if [ $REDIS_ID -eq 0 ];then
     start
   else
     stop
     sleep 2
     start
   fi
}
##########redis_6379 start,stop,restart######
case "$1" in
 start)
      start
      RETVAL=$?
;;
 stop)
      stop
      RETVAL=$?
;;
 restart)
      restart
      RETVAL=$?
;;
  *)
  echo "USAGE:$0 {start|stop|restart}"
esac
```

# redis_6479
```
#!/bin/sh
#chkconfig:345 86 15
#description:redis_6479 service

. /etc/init.d/functions
PR_ID=`ps -ef|grep redis|grep -v redis_6479|grep -v grep|grep 6479 |awk '{print $2}'`
REDIS_ID=`ps -ef|grep 6479|grep -v grep|wc -l`
start() {
  if [ $REDIS_ID -eq 1 ];then
     echo "redis_6479 is running"
     exit
  fi
  echo "REDIS is starting...."
  /usr/local/bin/redis-server --include /usr/local/redis_cluster/slave_6479/redis.conf > /dev/null > 1 >/tmp/redis_6479.log &
  if [ $? -eq 0 ];then
    action "redis_6479 started" /bin/true
  else
    action "redis_6479 started" /bin/false
  fi
}
stop() {
  if [ $REDIS_ID -eq 0 ];then
    echo "redis_6479 stopped"
    exit 1
  fi
  echo "REDIS is stopped....."
  kill -9 $PR_ID  2>&1 >/dev/null
  if [ $? -eq 0 ];then
    action "redis_6479 stopped" /bin/true
  else
    action "redis_6479 stopped" /bin/false
  fi
}
restart() {
   if [ $REDIS_ID -eq 0 ];then
     start
   else
     stop
     sleep 2
     start
   fi
}
##########redis_6479 start,stop,restart######
case "$1" in
 start)
      start
      RETVAL=$?
;;
 stop)
      stop
      RETVAL=$?
;;
 restart)
      restart
      RETVAL=$?
;;
  *)
  echo "USAGE:$0 {start|stop|restart}"
esac
```

# redis_6579
```
#!/bin/sh
#chkconfig:345 86 15
#description:redis_6579 service

. /etc/init.d/functions
PR_ID=`ps -ef|grep redis|grep -v redis_6579|grep -v grep|grep 6579 |awk '{print $2}'`
REDIS_ID=`ps -ef|grep 6579|grep -v grep|wc -l`
start() {
  if [ $REDIS_ID -eq 1 ];then
     echo "redis_6579 is running"
     exit
  fi
  echo "REDIS is starting...."
  /usr/local/bin/redis-server --include /usr/local/redis_cluster/slave_6579/redis.conf > /dev/null > 1 >/tmp/redis_6579.log &
  if [ $? -eq 0 ];then
    action "redis_6579 started" /bin/true
  else
    action "redis_6579 started" /bin/false
  fi
}
stop() {
  if [ $REDIS_ID -eq 0 ];then
    echo "redis_6579 stopped"
    exit 1
  fi
  echo "REDIS is stopped....."
  kill -9 $PR_ID  2>&1 >/dev/null
  if [ $? -eq 0 ];then
    action "redis_6579 stopped" /bin/true
  else
    action "redis_6579 stopped" /bin/false
  fi
}
restart() {
   if [ $REDIS_ID -eq 0 ];then
     start
   else
     stop
     sleep 2
     start
   fi
}
##########redis_6579 start,stop,restart######
case "$1" in
 start)
      start
      RETVAL=$?
;;
 stop)
      stop
      RETVAL=$?
;;
 restart)
      restart
      RETVAL=$?
;;
  *)
  echo "USAGE:$0 {start|stop|restart}"
esac
```
