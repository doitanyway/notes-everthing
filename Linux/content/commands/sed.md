# sed 

## 说明
Linux sed命令是利用script来处理文本文件。  
sed可依照script的指令，来处理、编辑文本文件。  
Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。   

## 语法

> ``sed [-hnV][-e<script>][-f<script文件>][文本文件]``

参数说明：
* ``-e<script>``或``--expression=<script>`` 以选项中指定的script来处理输入的文本文件。
* ``-f<script文件>``或``--file=<script文件>`` 以选项中指定的script文件来处理输入的文本文件。
* ``-h``或``--help`` 显示帮助。
* ``-n``或``--quiet``或``--silent`` 仅显示``script``处理后的结果。
* ``-V``或``--version`` 显示版本信息。

动作说明：
* a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
* c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
* d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
* i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
* p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
* s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！

## 例子

### 加一行数据

在 file.txt第四行后面加一行，内容为``newLine``
```
sed  '2a\new line'  test  # -e可以省略
```

```
$ sed  '2a\new line'  test
line 1
line 2
new line
line 3
```

### 以行为单位新增，删除

* 删除第二行

```
$ sed '1d' test
line 2
line 3
```
* 删除第1~2行

```
$ sed '1,2d' test
line 3
```

* 删除第 2 到最后一行

```
$ sed '2,$d' test
line 1
```

* 在第 2 行后加入字符串
```
$ sed '2a hello nick' test
line 1
line 2
hello nick
line 3
```

* 插入多行用``/``

```
$ sed '2a hello nick \
how are you!' test
line 1
line 2
hello nick
how are you!
line 3
```

* 替换匹配行,替换以APPMCHID开始的行为``APPMCHID=1222222222``

```
sed 's/^APPMCHID.*$/APPMCHID=1222222222/g' filename
```
