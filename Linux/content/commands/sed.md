# sed ,流编辑器

原文见： https://www.gnu.org/software/sed/manual/sed.html

## 说明

sed是一个流编辑器，流编辑用来执行输入流的转换。可以脚本化编辑文件。

sed可依照script的指令，来处理、编辑文本文件。  
Sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。  

## 执行sed

本章执行如何运行sed命令，sed script和详细的sed命令将会在下一个章节介绍。

* 概述
* 命令行option
* 退出码

### 概述

sed调用通常格式如下；  
```
sed SCRIPT INPUTFILE...
```

例如，如果我们想把输入文件input.txt中的``hello``替换成为``world``，则可执行如下命令:  

```
sed 's/hello/world/' input.txt > output.txt
```

如果不指定输入文件，sed命令将会把标准输入作为输入，下面的几个命令是等效的:

```
sed 's/hello/world/' input.txt > output.txt
sed 's/hello/world/' < input.txt > output.txt
cat input.txt | sed 's/hello/world/' - > output.txt
```

sed的输出默认是标准输出，如果我们想直接编辑输入文件可以使用 -i option.下面几个命令将会直接修改文件不产生任何输出到终端上；  

```
sed -i 's/hello/world/' file.txt
```

默认sed打印出所有处理过的输入. 可以使用-n 阻止输出，,可以使用p命令输出指定的行(1开始).下面的命令将会打印45行：  

```
sed -n '45p' file.txt
```

sed 按一个长的输入流来对待多个输入流.下面的例子将会打印第一个文件的的第一行，以及最后一个文件的最后一行.

```
sed -n  '1p ; $p' one.txt two.txt three.txt
```

如果没有-e或者-f选项，sed使用第一个非option的参数作为替换脚本，紧跟着的一个非option作为输入文件. 如果包含 -e 或者 -f option那么将会使用一个指定的脚本, 所有的非option参数将会作为输入文件. Options -e 和 -f 可以合并, 可以出现多次(在这种情况下，最终生效的脚本将会合并所有独立的脚本).

下面的列子等效:

```
sed 's/hello/world/' input.txt > output.txt
sed -e 's/hello/world/' input.txt > output.txt
sed --expression='s/hello/world/' input.txt > output.txt

echo 's/hello/world/' > myscript.sed
sed -f myscript.sed input.txt > output.txt
sed --file=myscript.sed input.txt > output.txt
```


### 命令行Options

sed命令的完整格式如下:

```
sed OPTIONS... [SCRIPT] [INPUTFILE...]
```

sed 的option可以是以下参数:

* --version
输出sed的版本.

* --help
打印简短的帮助信息。

* -n
 --quiet
 --silent  
默认情况下，sed会输出到标准输出上去，该选项会失能输出,加上该选项之后sed只会输出p命令指定的行。

* -e script
--expression=script
指定脚本.

* -f script-file
--file=script-file
指定脚本文件；

* -i[SUFFIX]
--in-place[=SUFFIX]
加入该选项后会实时的编辑该文件.

* --posix
GNU sed includes several extensions to POSIX sed. In order to simplify writing portable scripts, this option disables all the extensions that this manual documents, including additional commands. Most of the extensions accept sed programs that are outside the syntax mandated by POSIX, but some of them (such as the behavior of the N command described in Reporting Bugs) actually violate the standard. If you want to disable only the latter kind of extension, you can set the POSIXLY_CORRECT variable to a non-empty value.

* -b
--binary
This option is available on every platform, but is only effective where the operating system makes a distinction between text files and binary files. When such a distinction is made—as is the case for MS-DOS, Windows, Cygwin—text files are composed of lines separated by a carriage return and a line feed character, and sed does not see the ending CR. When this option is specified, sed will open input files in binary mode, thus not requesting this special processing and considering lines to end at a line feed.

* --follow-symlinks
This option is available only on platforms that support symbolic links and has an effect only if option -i is specified. In this case, if the file that is specified on the command line is a symbolic link, sed will follow the link and edit the ultimate destination of the link. The default behavior is to break the symbolic link, so that the link destination will not be modified.

* -E
-r
--regexp-extended
Use extended regular expressions rather than basic regular expressions. Extended regexps are those that egrep accepts; they can be clearer because they usually have fewer backslashes. Historically this was a GNU extension, but the -E extension has since been added to the POSIX standard (http://austingroupbugs.net/view.php?id=528), so use -E for portability. GNU sed has accepted -E as an undocumented option for years, and *BSD seds have accepted -E for years as well, but scripts that use -E might not port to other older systems. See Extended regular expressions.

* -s
--separate
By default, sed will consider the files specified on the command line as a single continuous long stream. This GNU sed extension allows the user to consider them as separate files: range addresses (such as ‘/abc/,/def/’) are not allowed to span several files, line numbers are relative to the start of each file, $ refers to the last line of each file, and files invoked from the R commands are rewound at the start of each file.

* --sandbox
In sandbox mode, e/w/r commands are rejected - programs containing them will be aborted without being run. Sandbox mode ensures sed operates only on the input files designated on the command line, and cannot run external programs.

* -u
--unbuffered
Buffer both input and output as minimally as practical. (This is particularly useful if the input is coming from the likes of ‘tail -f’, and you wish to see the transformed output as soon as possible.)

* -z
--null-data
--zero-terminated
Treat the input as a set of lines, each terminated by a zero byte (the ASCII ‘NUL’ character) instead of a newline. This option can be used with commands like ‘sort -z’ and ‘find -print0’ to process arbitrary file names.

If no -e, -f, --expression, or --file options are given on the command-line, then the first non-option argument on the command line is taken to be the script to be executed.

If any command-line parameters remain after processing the above, these parameters are interpreted as the names of input files to be processed. A file name of ‘-’ refers to the standard input stream. The standard input will be processed if no file names are specified.




### Exit 状态码

退出状态码为0代表成功,非0值代表失败:

* 0 - 成功

* 1 - 命令非法

* 2 - 一个或者多个输入文件不能被打开；

* 4 - I/O error

##  sed 脚本


• sed script overview:	  
• sed commands list:	  
• The "s" Command:	  	sed’s Swiss Army Knife
• Common Commands:	  	Often used commands
• Other Commands:	  	Less frequently used commands
• Programming Commands:	  	Commands for sed gurus
• Extended Commands:	  	Commands specific of GNU sed
• Multiple commands syntax:	  	Extension for easier scripting



## 正则表达式


为了更好的学习sed，我们应该理解正则表达式，它是用来匹配一个符合指定格式的一个字符串.正则表达式在sed里面使用2个/包含起来。


下面一个命令打印包含‘hello’的行；

```
sed -n '/hello/p' file
```

上面命令等效于``grep 'hello'``


正则表达式可以包含选择和重复，他不使用一些特殊字符表示；

字符^代表匹配行的开始，字符.代表匹配一个任意字符，下面一个命令代表匹配一个以b开始，紧接着一个任意字符，然后再有一个b字符的行；

```
$ printf "%s\n" abode bad bed bit bid byte body | sed -n '/^b.d/p'
bad
bed
bid
body
```

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
