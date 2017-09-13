# cat查看文件

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