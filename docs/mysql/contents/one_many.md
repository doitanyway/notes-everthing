#  一对多查询

如下，用户表和车辆表存在一对多的对应关系，本文讲解一对多关联查询。

```sql
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '0' COMMENT '车主用户ID',
  `license` varchar(10) DEFAULT '' COMMENT '车牌号码',
  `auto_pay` int(4) DEFAULT '0' COMMENT '是否自动支付  0否 1是',
  PRIMARY KEY (`Id`) USING BTREE,
	UNIQUE KEY `index_license` (`license`) USING BTREE
) COMMENT='车主车辆绑定信息表';

DROP TABLE IF EXISTS `app_users`;
CREATE TABLE `app_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `balance` int(11) DEFAULT '0' COMMENT '帐户余额，单位分',
  `login_status` int(4) DEFAULT '0' COMMENT '登录状态 0离线 1在线',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_mobile` (`mobile`) USING BTREE
) COMMENT='车主用户表';
```


* 初始化数据

```sql
INSERT INTO `app_users` (`id`,`mobile`,`email`,`balance`,`login_status`) VALUES (1,'18111111111',NULL,0,0);
INSERT INTO `cars` (`user_id`,`license`) VALUES (1,'粤B111111');
INSERT INTO `cars` (`user_id`,`license`) VALUES (1,'粤B222222');
INSERT INTO `app_users` (`id`,`mobile`,`email`,`balance`,`login_status`) VALUES (2,'18222222222',NULL,0,0);
INSERT INTO `cars` (`user_id`,`license`) VALUES (2,'粤B333333');

INSERT INTO `app_users` (`id`,`mobile`,`email`,`balance`,`login_status`) VALUES (3,'18333333333',NULL,0,0);
```

## 查找数据

* 按用户查看，车牌链接成为一个字符串显示。

```sql
SELECT u.id,u.mobile,group_concat(c.license) FROM app_users u LEFT JOIN cars c on c.user_id=u.id group by mobile;
```

```
id	mobile	group_concat(c.license)
1	18111111111	粤B111111,粤B222222
2	18222222222	粤B333333
3	18333333333	
```

* 加筛选条件

```sql
SELECT u.id,u.mobile,group_concat(c.license) FROM app_users u LEFT JOIN cars c on c.user_id=u.id WHERE u.mobile="18111111111" group by mobile;
```