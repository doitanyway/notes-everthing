# shell脚本编写

## 前言

本文介绍常用的一些shell脚本的编写方法

## 变量

```shell
#!/bin/bash
#声明一个变量
VARIABLE="variable1"  

# 变量的使用和拼接
echo $VARIABLE
echo ${VARIABLE}/122

# 判断变量是否存在
if [ -z "$VARIABLE" ]; then
    echo "no found variable"
fi


if [ -z "$VARIABLE" ]; then
    echo "no found variable"
else 
    echo "found variable"
fi
```

## 条件if

* 查看变量是否存在

```sh
if [ $JAVA_HOME ];then
  echo "not found java_home"
else
  echo "found java_home"
fi
```

* 查看程序是否安装
```sh
if [ -z $(which zip) ]; then
        echo "Not found zip."
        yum install -y zip
else
        echo "found zip"
fi
```

* 查看文件是否存在

```sh
if [ -a "hello" ];then
        echo "found hello"
else
        echo "not found hello"
fi
```

更多条件：
* [ -a FILE ] 如果 FILE 存在则为真。 
* [ -b FILE ] 如果 FILE 存在且是一个块特殊文件则为真。
* [ -c FILE ] 如果 FILE 存在且是一个字特殊文件则为真。 
* [ -d FILE ] 如果 FILE 存在且是一个目录则为真。 
* [ -e FILE ] 如果 FILE 存在则为真。
* [ -f FILE ] 如果 FILE 存在且是一个普通文件则为真。 
* [ -g FILE ] 如果 FILE 存在且已经设置了SGID则为真。 
* [ -h FILE ] 如果 FILE 存在且是一个符号连接则为真。 
* [ -k FILE ] 如果 FILE 存在且已经设置了粘制位则为真。 
* [ -p FILE ] 如果 FILE 存在且是一个名字管道(F如果O)则为真。 
* [ -r FILE ] 如果 FILE 存在且是可读的则为真。 
* [ -s FILE ] 如果 FILE 存在且大小不为0则为真。  
* [ -t FD ] 如果文件描述符 FD 打开且指向一个终端则为真。 
* [ -u FILE ] 如果 FILE 存在且设置了SUID (set user ID)则为真。 
* [ -w FILE ] 如果 FILE 如果 FILE 存在且是可写的则为真。 
* [ -x FILE ] 如果 FILE 存在且是可执行的则为真。 
* [ -O FILE ] 如果 FILE 存在且属有效用户ID则为真。 
* [ -G FILE ] 如果 FILE 存在且属有效用户组则为真。 
* [ -L FILE ] 如果 FILE 存在且是一个符号连接则为真。  
* [ -N FILE ] 如果 FILE 存在 and has been mod如果ied since it was last read则为真。
* [ -S FILE ] 如果 FILE 存在且是一个套接字则为真。  
* [ FILE1 -nt FILE2 ] 如果 FILE1 has been changed more recently than FILE2,or 如果 FILE1 exists and FILE2 does not则为真。  
* [ FILE1 -ot FILE2 ] 如果 FILE1 比 FILE2 要老, 或者 FILE2 存在且 FILE1 不存在则为真。  
* [ FILE1 -ef FILE2 ] 如果 FILE1 和 FILE2 指向相同的设备和节点号则为真。 
* [ -o OPTIONNAME ] 如果 shell选项 “OPTIONNAME” 开启则为真。 
* [ -z STRING ] “STRING” 的长度为零则为真。  
* [ -n STRING ] or [ STRING ] “STRING” 的长度为非零 non-zero则为真。 

* [ ARG1 OP ARG2 ] “OP” is one of -eq, -ne, -lt, -le, -gt or -ge. These arithmetic binary operators return true if “ARG1” is equal to, not equal to, less than, less than or equal to, greater than, or greater than or equal to “ARG2”, respectively. “ARG1” and “ARG2” are integers. 


* 数字判断 [ $count -gt "1"] 如果$count 大于1 为真
    * -gt  大于
    * -lt    小于
    * -ne  不等于
    * -eq  等于
    * -ge  大于等于
    * -le  小于等于

* [ STRING1 == STRING2 ] 如果2个字符串相同。 “=” may be used instead of “==” for strict POSIX compliance则为真。  
* [ STRING1 != STRING2 ] 如果字符串不相等则为真。  
* [ STRING1 < STRING2 ] 如果 “STRING1” sorts before “STRING2” lexicographically in the current locale则为真。  
* [ STRING1 > STRING2 ] 如果 “STRING1” sorts after “STRING2” lexicographically in the current locale则为真。

## 读取数据read

```sh
#!/bin/bash
#testing the read command

# 基础读
echo -n "Enter you name:"   #echo -n 让用户直接在后面输入 
read name  #输入的多个文本将保存在一个变量中
echo "Hello $name, welcome to my program."

# 在read命令前加提示
read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That makes you over $days days old!"

# 超时读
if read -t 5 -p "Please enter your name: " name     #记得加-p参数， 直接在read命令行指定提示符
then
        echo "Hello $name, welcome to my script"
else
        echo "Sorry, too slow!"
fi

# 隐藏方式读取(read -s)
read -s -p "Enter your passwd: " pass   #-s 参数使得read读入的字符隐藏
echo
echo "Is your passwd readlly $pass?"

# 从文本中读取
count=1
cat hello | while read line   # hello是当前目录下的一个文本文件
do
        echo "Line $count: $line"
        count=$[ $count + 1 ]
done
echo "Finished processing the file"
```

## case 条件   

```sh
#!/bin/bash
#testing the case 

read -p "Please enter your age: " age
case $age in
        1)
        echo "1 year old."
        ;;
        *)
        echo "do not know."
        ;;
esac


read -p "Please enter your name: " name

case $name in
        nick|n)
        echo "hi Nick"
        ;;
        e*)
        echo "hello elaine"
        ;;
        *)
        echo "who are you?"
        ;;
esac
```

## 循环  
参考 https://blog.csdn.net/taiyang1987912/article/details/38929069


# 函数

```sh
#!/bin/bash

function hello_fun(){
        echo $1
        echo $2
        count=0;
        while [ $count -lt $1 ];
        do
                echo $count;
                let ++count; # 指定let后面是算数运算符
                sleep 1;
        done
        return $2;
}

result=
max(){
        if [ $1 -gt $2 ]; then
                result=$1
        else
                result=$2
        fi
}

read -p "input param 1:" n1;
read -p "input param 2:" n2;

# return 返回值
hello_fun $n1 $n2
echo "res="$?

# 全局返回值
max $n1 $n2
echo "global=$result"
```

## 脚本传入参数

```sh
#!/bin/bash
echo $0
echo $1
```

执行：    
```sh
[root@bogon ssh]# ./param.sh 122
./param.sh
122
```

## 获取日期

```SH
var=$(date "+%Y-%m-%d %H:%M:%S")
echo ${var}
```


## 循环执行命令

array=(node1 node2 node3)
for node in ${array[@]}; do 
echo $node;
echo 1:$node;
done

## 远程执行

ssh user@remoteNode "cd /home ; ls"

