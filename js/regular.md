# 正则表达式 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [JavaScript 正则表达式](#javascript-正则表达式)
* [什么是正则表达式？](#什么是正则表达式)
* [语法](#语法)
* [使用字符串方法](#使用字符串方法)
	* [search() 方法使用正则表达式](#search-方法使用正则表达式)
	* [replace() 方法](#replace-方法)
* [正则表达式的模式](#正则表达式的模式)
* [使用 RegExp 对象](#使用-regexp-对象)
	* [使用 test()](#使用-test)
	* [使用 exec()](#使用-exec)
* [常用实列](#常用实列)
* [更多参考](#更多参考)

<!-- /code_chunk_output -->

## JavaScript 正则表达式

正则表达式（英语：Regular Expression，在代码中常简写为regex、regexp或RE）使用单个字符串来描述、匹配一系列符合某个句法规则的字符串搜索模式。 
搜索模式可用于文本搜索和文本替换。

## 什么是正则表达式？

正则表达式是由一个字符序列形成的搜索模式。  
当你在文本中搜索数据时，你可以用搜索模式来描述你要查询的内容。  
正则表达式可以是一个简单的字符，或一个更复杂的模式。  
正则表达式可用于所有文本搜索和文本替换的操作。   

## 语法

```
/正则表达式主体/修饰符(可选)
```
其中修饰符是可选的。实例：
```
var patt = /runoob/i
```
分析：  
/runoob/i  是一个正则表达式。  
runoob  是一个正则表达式主体 (用于检索)。  
i  是一个修饰符 (搜索不区分大小写)。   
参数：  

| 参数值 | 含义                                                  |
|--------|-------------------------------------------------------|
| i      | 不区分大小写                                          |
| g      | 执行全局匹配（查找所有匹配而非在找到第一个匹配后停止）。 |
| m      | 执行多行匹配。                                         |

## 使用字符串方法

在 JavaScript 中，正则表达式通常用于两个字符串方法 : search() 和 replace()。  
search() 方法 用于检索字符串中指定的子字符串，或检索与正则表达式相匹配的子字符串，并返回子串的起始位置。  
replace() 方法 用于在字符串中用一些字符替换另一些字符，或替换一个与正则表达式匹配的子串。  

### search() 方法使用正则表达式

检索子字符串，检索“Runoob”子串
```
var str = "Visit Runoob!"; 
var n = str.search("Runoob");
console.log("n:"+n);
```

### replace() 方法

* 使用正则表达式

使用正则表达式子且不区分大小写替换microsoft为Runoob。
```
var str = "Visit Microsoft!"; 
var txt = str.replace(/microsoft/i,"Runoob");
console.log("txt:"+txt);
```

* 使用字符串

```
var str = "Visit Microsoft!"; 
var txt = str.replace("Microsoft","Runoob");
```
如上可以看出，replace既可以使用正则表达式，也可以使用字符串查找，但是正则表达式，能够实现更复杂的查找方法。

## 正则表达式的模式

* 查找某个范围字符

| 表达式 | 描述                      |
|--------|---------------------------|
| [abc]  | 查找方括号之间的任何字符。 |
| [0-9]  | 查找任何从 0 至 9 的数字。 |
|(x\|y)|查找任何以 \| 分隔的选项。？？？？|


* 元字符是拥有特殊含义的字符：

| 元字符  | 描述                                       |
|---------|--------------------------------------------|
| \\d     | 查找数字。                                  |
| \\s     | 查找空白字符。                              |
| \\b     | 匹配单词边界。                              |
| \\uxxxx | 查找以十六进制数 xxxx 规定的 Unicode 字符。 |

* 量词:

| 量词 | 描述                               |
|------|------------------------------------|
| n+   | 匹配任何包含至少一个 n 的字符串。   |
| n*   | 匹配任何包含零个或多个 n 的字符串。 |
| n?   | 匹配任何包含零个或一个 n 的字符串。 |


## 使用 RegExp 对象
在 JavaScript 中，RegExp 对象是一个预定义了属性和方法的正则表达式对象。

### 使用 test()

test() 方法是一个正则表达式方法。
test() 方法用于检测一个字符串是否匹配某个模式，如果字符串中含有匹配的文本，则返回 true，否则返回 false。
以下实例用于搜索字符串中的字符 "e"：
```
/e/.test("The best things in life are free!")
```

### 使用 exec()

exec() 方法是一个正则表达式方法。
exec() 方法用于检索字符串中的正则表达式的匹配。
该函数返回一个数组，其中存放匹配的结果。如果未找到匹配，则返回值为 null。
以下实例用于搜索字符串中的字母 "e":
```
/e/.exec("The best things in life are free!");
```


## 常用实列

```
/*是否带有小数*/
function    isDecimal(strValue )  {  
   var  objRegExp= /^\d+\.\d+$/;
   return  objRegExp.test(strValue);  
}  

/*校验是否中文名称组成 */
function ischina(str) {
    var reg=/^[\u4E00-\u9FA5]{2,4}$/;   /*定义验证表达式*/
    return reg.test(str);     /*进行验证*/
}

/*校验是否全由8位数字组成 */
function isStudentNo(str) {
    var reg=/^[0-9]{8}$/;   /*定义验证表达式*/
    return reg.test(str);     /*进行验证*/
}

/*校验电话码格式 */
function isTelCode(str) {
    var reg= /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
    return reg.test(str);
}

/*校验邮件地址是否合法 */
function IsEmail(str) {
    var reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
    return reg.test(str);
}
```


## 更多参考

更多参考，请查看 http://www.runoob.com/jsref/jsref-obj-regexp.html
