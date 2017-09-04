# Linux常用命令 {ignore=false}

## cat 查看文件
* cat [filename]
查看文件,示例如下，这命令不适合大文件;
* cat [filename] | grep -a "[string]" 
查看包含某个字符串的文件行;
* cat [filename] -n | grep -a "[string]"
查看包含某个字符串的文件,并且打印行号；
* cat [filename] -n | grep -a "[string]" | head -n 10
查看包含某个字符串的文件,打印行号,前10行文件；
* cat [filename] -n | grep -a "[string]" | tail -n 10
查看包含某个字符串的文件,打印行号,前10行文件；
* cat [filename] -n | grep -a -E "[string1]|[string2]"
满足其中一个条件查找
* cat [filename] -n | grep -a -E "[string2]"|grep -a -E "[string1]"
满足多个条件的查找
* cat [filename] | less
分页显示（less关键字,前面的所有命令如果需要也可以加less）。
* cat [filename] | grep -a "[string]| ws -l
统计符合条件的结果个数



注：该应用用来查找日志文件，有较大优势，速度较快。下面举例演示：
* 分页查看catalina.out文件：``cat catalina.out|less``
* 分页查看catalina.out文件8点的日志：``cat catalina.out|grep -a "08:00:"|less``
* 分页查看某个基站的汇报 `` cat catalina.out -n | grep -a "设备类型:A1,设备(版本)Id:013333,命令:F1," |less``
* 查看文件前面100行``cat catalina.out|head -n 100``
* 查看文件前面100行,并显示行号``cat catalina.out -n|head -n 100``
* 查看文件最后100行,并显示行号``cat catalina.out -n|tail -n 100``
* 统计查询结果条数``cat catalina.out -n|tail -n 100|wc -l``
* 把两天的日志转存到文件``cat catalina.out | grep -a -E "2017-08-22|2017-08-21" >log.log``

## ./mysqldump -uroot -p -d DB1>/home/leo/db1.sql
* 备份数据库,``mysqldump -uroot -pXXXX  dbname>/home/db1.sql``
* 备份数据库，只备份结构``mysqldump -uroot -pXXXX -d dbname>/home/db1.sql``
* 还原数据库,``mysql -uroot -pXXXX dbname < backup.sq``


## ifconfig查看网络信息1

## tar 
### 解压

-c: 建立压缩档案

-x：解压

-t：查看内容

-r：向压缩归档文件末尾追加文件

-u：更新原压缩包中的文件

这五个是独立的命令，压缩解压都要用到其中一个，可以和别的命令连用但只能用其中一个。下面的参数是根据需要在压缩或解压档案时可选的。

-z：有gzip属性的

-j：有bz2属性的

-Z：有compress属性的

-v：显示所有过程

-O：将文件解开到标准输出


下面的参数-f是必须的

-f: 使用档案名字，切记，这个参数是最后一个参数，后面只能接档案名。
```
tar -cf all.tar *.jpg
```
这条命令是将所有.jpg的文件打成一个名为all.tar的包。-c是表示产生新的包，-f指定包的文件名。
```
tar -rf all.tar *.gif
```
这条命令是将所有.gif的文件增加到all.tar的包里面去。-r是表示增加文件的意思。
```
tar -uf all.tar logo.gif
```
这条命令是更新原来tar包all.tar中logo.gif文件，-u是表示更新文件的意思。
```
tar -tf all.tar
```
这条命令是列出all.tar包中所有文件，-t是列出文件的意思
```
# tar -xf all.tar
```
这条命令是解出all.tar包中所有文件，-t是解开的意思

### 压缩
```
tar -cvf jpg.tar *.jpg  将目录里所有jpg文件打包成tar.jpg 

tar -czf jpg.tar.gz *.jpg   将目录里所有jpg文件打包成jpg.tar后，并且将其用gzip压缩，生成一个gzip压缩过的包，命名为jpg.tar.gz

tar -cjf jpg.tar.bz2 *.jpg 将目录里所有jpg文件打包成jpg.tar后，并且将其用bzip2压缩，生成一个bzip2压缩过的包，命名为jpg.tar.bz2

tar -cZf jpg.tar.Z *.jpg   将目录里所有jpg文件打包成jpg.tar后，并且将其用compress压缩，生成一个umcompress压缩过的包，命名为jpg.tar.Z

rar a jpg.rar *.jpg rar格式的压缩，需要先下载rar for linux

zip jpg.zip *.jpg zip格式的压缩，需要先下载zip for linux
```

### 解压 


tar -xvf file.tar 解压 tar包

tar -xzvf file.tar.gz 解压tar.gz

tar -xjvf file.tar.bz2   解压 tar.bz2

tar -xZvf file.tar.Z   解压tar.Z

unrar e file.rar 解压rar

unzip file.zip 解压zip

### 总结 


* *.tar 用 tar -xvf 解压

* *.gz 用 gzip -d或者gunzip 解压

* *.tar.gz和*.tgz 用 tar -xzf 解压

* *.bz2 用 bzip2 -d或者用bunzip2 解压

* *.tar.bz2用tar -xjf 解压

* *.Z 用 uncompress 解压

* *.tar.Z 用tar -xZf 解压

* *.rar 用 unrar e解压

* *.zip 用 unzip 解压


