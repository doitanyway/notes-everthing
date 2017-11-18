# 查找相同Mysql记录

## 用途

查询MYSQL表中的某列有重复数据的数据项

## 创建数据表

```sql
create table product1(id int,name varchar(10),name1 varchar(10),totol int);
 
insert into product1 values (1,'香蕉','香蕉',100);
insert into product1 values (2,'橘子','橘子',67);
insert into product1 values (3,'葡萄','葡萄',89);
insert into product1 values (4,'苹果','苹果',235);
insert into product1 values (5,'香蕉','香蕉',77);
insert into product1 values (6,'芒果','芒果',34);
insert into product1 values (7,'葡萄','葡萄',78);
insert into product1 values (8,'梨','梨',24);
```

## 查询一列重复

```sql
select * from product1 group by name having COUNT(*)>1
```

## 查询两列重复

```
SELECT *,CONCAT(a.name,a.name1) as is_repeat from product1 a GROUP BY is_repeat HAVING COUNT(*)>1;
```
或者
```
SELECT a.id,a.name,a.name1,CONCAT(a.name,a.name1) as is_repeat from product1 a GROUP BY is_repeat HAVING COUNT(*)>1;
```
