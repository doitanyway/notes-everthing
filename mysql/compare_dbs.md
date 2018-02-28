# 比较数据库结构

## 简要介绍
当前现场有数据库，不知道升级到什么步骤了，SVN号码和脚本也对应不上来。我们可以通过导出不包含数据库数据的文件，对比sql结构的方法，同步数据库结构。  
本文假设有两个数据库db_a和db_b，其中db_a是现场的系统，db_b是我们升级版本的服务器数据结构。



## 执行安装包中的初始化脚本生成db_b


```
shell> mysql -uroot -p<password>
mysql> create database db_b character set utf8 collate utf8_general_ci;
mysql> exit;
shell> cat /home/init1.sql | mysql -uroot -p db_b
shell> cat /home/init2.sql | mysql -uroot -p db_b
shell> cat /home/init3.sql | mysql -uroot -p db_b
```

## 导出数据库文件

```
mysqldump -R -uroot -pXXXXX db_a --no-data>/home/a.sql
mysqldump -R -uroot -pXXXXX db_b --no-data>/home/b.sql
```

## 比较文件

使用BCompare比较两个数据库，看那部分未执行；
