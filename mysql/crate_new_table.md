# 基于现在的表创建新表

## 创建相同表
创建相同表，不拷贝记录
```sql
create table departments_t like departments;
```

## 创建相同表，拷贝记录

```sql
CREATE TABLE tbl_cust_charge_history1 AS   
(   
SELECT id, cust_id AS cust_id1, platform_type AS platform_type1, wx_open_id AS wx_open_id1 FROM tbl_cust_charge_history   
)  
```