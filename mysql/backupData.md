#  MySQLdump笔记

* 备份本地数据
    * cmd进入到MySQL的bin目录下，执行命令：
     ``mysqldump --host=localhost -uroot -p123456 --databases   jweb > D:\xwz\myshell\backup\db.sql``
    * 例： ``C:\Program Files\MySQL\MySQL Server 5.7\bin>mysqldump --host=localhost -uroot -p123456 --databases   jweb > D:\xwz\myshell\backup\db.sql`` 备份到D盘某目录下，备份成功后自动生成db.sql文件  

* 备份服务器数据雷同本地指令

* 跨服务器导出导入数据  
  ``mysqldump --host=h1 -uroot -proot --databases db1 |mysql --host=h2 -uroot -proot db2``
* 只导出表结构不导出数据``--no-data``
  ``mysqldump -uroot -proot --no-data --databases db1 > D:/xwz/db.sql``  
* 导出某个表的数据
 ``mysqldump -uroot -proot --databases db1 --tables a1 a2  > D:/xwz/db.sql``
