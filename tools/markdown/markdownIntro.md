# Markdown使用 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [软件安装](#软件安装)
* [markdown 语法](#markdown-语法)
	* [标题](#标题)
	* [正文](#正文)
	* [表格](#表格)
	* [超链接](#超链接)
	* [图片](#图片)
	* [mermaid](#mermaid)

<!-- /code_chunk_output -->
## 软件安装
使用markdown编辑文件，最好有一些配套软件，可预览，编辑文件；同时也可以生成html以及pdf文件。请参考下面文章安装软件；

* [VS Code](/vs_code/readme.md)
* [Git](/git/readme.md)
* [Nodejs](/Nodejs/install.md)


## markdown 语法
### 标题

```
# 标题1
## 标题2
### 标题3
#### 标题4
##### 标题5
```

效果：

![](assets/2017-08-21-20-36-03.png)

### 正文

* 普通正文，直接输入即可；
* 背景灰,`灰色背景示例`；

```
`灰色背景示例`
```

* 斜体,*斜体*；

```
*斜体*
```

* 强调,**强调**；

```
*强调*
```

### 表格

```
|col1|col|
|----|---|
|col1|col|
|col1|col|
```

效果如下图
![](assets/2017-08-21-21-00-25.png)


### 超链接

格式：
```
[文字](url)
```
如：
```
[官网](https://www.baidu.com)
```
效果：
[官网](https://www.baidu.com)

### 图片
格式：
```
[alt](url_or_path)
```
如：
```
[alt](assets/2017-08-21-21-00-25.png)
```
效果：
![alt](assets/2017-08-21-21-00-25.png)

### mermaid
使用mermaid需要把代码用如下字符串包含：

![](assets/2017-08-23-20-01-26.png)

更多详细内容请参考：https://mermaidjs.github.io/demos.html

### 其他

如果想更深层次的学习markdown 可关注[该网址](https://shd101wyy.github.io/markdown-preview-enhanced/#/markdown-basics)。
