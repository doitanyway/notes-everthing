# 备份-OUTFILE,还原-LOAD

## 测试数据准备  

```sql
mysql -uroot -proot
CREATE DATABASE IF NOT EXISTS db1 default charset utf8 COLLATE utf8_general_ci; 
USE db1;
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `db1`.`user`(`id`, `email`, `name`, `age`) VALUES (1, 'qiujdd@qq.com', 'nick', 20);
INSERT INTO `db1`.`user`(`id`, `email`, `name`, `age`) VALUES (2, 'elaine@dd.com', 'hangsa', 30);
INSERT INTO `db1`.`user`(`id`, `email`, `name`, `age`) VALUES (3, 'lily@11.com', 'lily', 32);
```


## 使用SELECT INTO OUTFILE命令导出数据

* SELECT 列1，列2 INTO OUTFILE '文件路径和文件名' FROM 表名字; 

示例语句：   
```sql
USE db1;
SELECT * INTO OUTFILE '/tmp/testfile.txt' FROM user;
-- 
-- select id,name into outfile "/var/lib/mysql-files/test.txt" lines terminated by "\r\n" from test;
```

* 导出文件格式如下``/tmp/testfile.txt``： 
```
1	qiujdd@qq.com	nick	20
2	elaine@dd.com	hangsa	30
3	lily@11.com	lily	32
```

>  该方法导出，需要配置参数``secure-file-priv``,其中``secure-file-priv=""``代表不限制导出文件路径，写指定路径代表固定导出文件的路径，其他为不允许导出


## 使用mysqldump导出 

* 导出文件格式如下；

```bash 
mysqldump -uroot -p'root' -t -T /tmp/ \
  db1 user  --fields-terminated-by=' ' --fields-enclosed-by='\"';
```

* 导出后，会产生``/tmp/user.txt``  
```
"1","qiujdd@qq.com","nick","20"
"2","elaine@dd.com","hangsa","30"
"3","lily@11.com","lily","32"
```

## 使用LOAD DATA导入数据

LOAD DATA INFILE '文件路径和文件名' INTO TABLE 表名字; 

示例语句：  
```sql
USE db1;
DROP TABLE IF EXISTS `user1`;
CREATE TABLE `user1` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 导入文件 testfile.txt测试
LOAD DATA INFILE '/tmp/testfile.txt' INTO TABLE user1 
FIELDS TERMINATED BY '\t'
ENCLOSED BY '\'';

-- 清理
truncate table user1;
-- 导入 user.txt文件测试   
LOAD DATA INFILE '/tmp/user.txt' INTO TABLE user1 
FIELDS TERMINATED BY ','
ENCLOSED BY '\"';

```


