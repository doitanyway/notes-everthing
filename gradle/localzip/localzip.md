# 设置下载本地gradlexx.zip {ignore=true}


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [找到文件下载地址](#找到文件下载地址)
* [设置工程文件](#设置工程文件)
* [重新执行``gradlew build``](#重新执行gradlew-build)

<!-- /code_chunk_output -->


## 找到文件下载地址

```
$ ./gradlew build
Downloading https://services.gradle.org/distributions/gradle-2.13-bin.zip
```
执行上面命令，确定gradle安装包的下载地址；

## 设置工程文件

打开文件``gradle\wrapper\gradle-wrapper.properties``，设置``distributionUrl``
```
distributionUrl=file:///C:/gradle/gradle-2.13-bin.zip
```

## 重新执行``gradlew build``