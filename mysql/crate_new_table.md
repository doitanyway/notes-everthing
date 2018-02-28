# 基于现在的表创建新表

## 创建相同表

* 创建相同表

```sql
mysql> create table departments_t like departments;
```

* 插入记录  

```sql
mysql> insert into departments_t select * from departments;
```

## 创建类似表

```sql
CREATE TABLE tbl_cust_charge_history1 AS   
(   
SELECT id, cust_id AS cust_id1, platform_type AS platform_type1, wx_open_id AS wx_open_id1 FROM tbl_cust_charge_history   
)  
```

上边语句创建了一个与之前表类似的表格,并且插入了相关记录；