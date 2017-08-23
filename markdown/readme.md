
# Markdown基础命令 {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [标题](#标题)
* [正文](#正文)
* [表格](#表格)
* [超链接](#超链接)
* [图片](#图片)
* [mermaid](#mermaid)
	* [流程图](#流程图)

<!-- /code_chunk_output -->

## 标题

```
# 标题1
## 标题2
### 标题3
#### 标题4
##### 标题5
```

效果：

![](assets/2017-08-21-20-36-03.png)

## 正文

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

## 表格

```
|col1|col|
|----|---|
|col1|col|
|col1|col|
```

效果如下图
![](assets/2017-08-21-21-00-25.png)


## 超链接

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

## 图片
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

## mermaid

### 流程图

**例子:**
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

![](assets/2017-08-23-19-47-47.png)

**方向:**
* TB - top bottom
* BT - bottom top
* RL - right left
* LR - left right

**节点：**

![](assets/2017-08-23-19-53-16.png)

![](assets/2017-08-23-19-53-26.png)

![](assets/2017-08-23-19-53-38.png)

![](assets/2017-08-23-19-53-55.png)

![](assets/2017-08-23-19-54-09.png)

![](assets/2017-08-23-19-54-19.png)

![](assets/2017-08-23-19-54-36.png)

![](assets/2017-08-23-19-54-48.png)

![](assets/2017-08-23-19-55-00.png)

![](assets/2017-08-23-19-55-24.png)

![](assets/2017-08-23-19-55-33.png)

![](assets/2017-08-23-19-55-45.png)

![](assets/2017-08-23-19-56-04.png)




**带文字的节点**

