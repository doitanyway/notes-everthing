# Linux常用命令 {ignore=false}

## cat 查看文件
* cat [filename]
查看某个文件
* cat [filename] | grep -a "[string]"
查看包含某个字符串的文件
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
* cat [filename] | more
分页显示。

注：该应用用来查找日志文件，有较大优势，速度较快。

## ifconfig查看网络信息


