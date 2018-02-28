# 克隆系统

## 简要介绍

在升级系统之前为避免系统升级出差希望能够快速恢复，我们经常需要克隆一个系统出来然后再升级，如果系统出错可以直接切换。


## 操作步骤

### 克隆数据库
1. 首先创建新的数据库newdb

```
# mysql -uroot -p
mysql> create database urpcs_new character set utf8 collate utf8_general_ci;
```

2. 使用mysqldump及mysql的命令组合，一次性完成复制
```
# mysqldump -R urpcs -uroot -ppassword --add-drop-table | mysql urpcs_new -uroot -ppassword
```

### 克隆文件

```
cp /user/local/tomcat/ /user/local/tomcat_clone
```
