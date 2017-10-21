# git与gitbook {ignore=true}
---
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* [前言](#前言)
* [安装软件](#安装软件)
* [常用命令](#常用命令)
	* [git命令](#git命令)
	* [gitbook命令](#gitbook命令)
* [git全局设置](#git全局设置)
* [克隆本地一个新仓库](#克隆本地一个新仓库)
* [已经存在的文件](#已经存在的文件)
* [已经存在的git本地仓库](#已经存在的git本地仓库)
* [发布版本](#发布版本)
* [切换远程分支](#切换远程分支)
* [忽略文件](#忽略文件)
* [解決冲突](#解決冲突)
* [分支合并](#分支合并)
	* [创建并导出一个分支](#创建并导出一个分支)
	* [提交代码](#提交代码)
	* [合并代码](#合并代码)
	* [发布版本](#发布版本-1)

<!-- /code_chunk_output -->
---
## 前言
git：版本管理工具，可以和github配合使用；

gitbook：电子书生成工具；

calibre：PDF格式电子书转换需要；

本文介绍上面三个软件的安装和使用,假设读者电脑已经安装好了node，如果没有安装好node，请参考【[node安装](/tools/Nodejs/install.md)】
## 安装软件 
* [官网](https://git-scm.com/downloads)下载git安装。如果是在windows下安装，请选择安装LINUX命令，这将对你以后的研发很有帮助。  
![](assets/markdown-img-paste-20170813103947623.png)

* 设置用户名、邮箱
	```
	git config --global user.email "xxx@szfangle.com"
	git config --global user.name "xxx"
	```

* 管理员执行命令，安装gitbook
```
cnpm install gitbook-cli -g --save
```
* 安装calibre
到[官网](https://calibre-ebook.com/download_windows)下载安装；


## 常用命令
### git命令

| 命令                                  | 说明                     |
|---------------------------------------|--------------------------|
| git init                              | 初始化仓库               |
| git add .                             | 添加新文件或者更改新文件 |
| git add filename                      | 添加一个文件             |
| git commit -m "comment"               | 提交文件到本地           |
| git remote                            | 列出已经存在的远程分支   |
| git remote remove <name>              | 删除远程分支             |
| git clone https://url/testTitle.git   | 克隆到本地               |
| git fetch branch2                     | 更新信息                 |
| git merge branch2/master              | merge本地信息            |
| git remove  **                        | 删除文件                 |
| git push                              | push到服务器上           |
| git pull origin master                | 从服务器上拉取信息       |
| git branch -a                         | 查看所有分支             |
| git branch -r                         | 查看远程分支             |
| git branch -d ***                     | 删除分支                 |
| git branch  ***                       | 新建分支                 |
| git checkout ***                      | 切换分支                 |
| git status                            | 查看状态                 |
| git log                               | 查看提交修改记录         |
| git checkout filename                 | 恢复删除文件             |
| git push --set-upstream origin master | 设置push到哪里           |
|git tag -d v1.1                        | 删除版本                 |

### gitbook命令
| 命令            | 说明      |
|---------------|---------|
| gitbook init  | 初始化     |
| gitbook build | 生成HTML  |
| gitbook serve | 打开浏览器服务 |
| gitbook pdf   | 生成PDF   |
| gitbook pdf ./ readme.pdf   | 按名字生成PDF   |




## git全局设置

```
git config --global user.name "name"
git config --global user.email "name@szfangle.com"
```

## 克隆本地一个新仓库

```
git clone http://58.250.204.146:6002/qiujiahong/test.git
cd test
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

## 已经存在的文件

```
cd existing_folder
git init
git remote add origin http://58.250.204.146:6002/qiujiahong/test.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

## 已经存在的git本地仓库

```
cd existing_repo
git remote add origin http://58.250.204.146:6002/qiujiahong/test.git
git push -u origin --all
git push -u origin --tags
```


## 发布版本

* 查看tag
	```
	git tag
	```

* 查看当前提交
	```
	git log -n 1
	```
* 新建tag
	>git tag -a "tagname" id  -m "[comment]"
	```
	git tag -a "v1.0.1" dad6772a3ba211453d2112ce2e4763f97b7414b1 -m "this is a test"
	```

* 提交tag
	>git push origin [tagname]
	```
	git push origin v1.0.1
	```
* 刪除tag
	```	
	git tag -d tagname
	```

## 切换远程分支

* 列举所有分支
	```
	$ git branch --all
	* master
	remotes/origin/HEAD -> origin/master
	remotes/origin/master
	remotes/origin/xiantingche_ios
	```

* 切换分支
	```
	$ git checkout master
	Switched to branch 'master'
	Your branch is up-to-date with 'origin/master'.
	```


## 忽略文件

在git项目跟目录下建立文件``.gitignore``,把需要忽略的文件或者是文件夹写在文件内,把改文件提交到服务器即可生效；

* 忽略指定文件
	```
	# Windows:
	Thumbs.db
	ehthumbs.db
	Desktop.ini
	```

* 忽略匹配的文件
	```
	# Python:
	*.py[cod]
	*.so
	*.egg
	*.egg-info
	```

* 忽略文件夹
	```
	dist
	build
	```

* 强制添加文件
	如果想提交按``.gitignore``文件规则匹配的文件或者文件夹则使用强制提交命令,如下：
	```
	$ git add -f App.class
	```

## 解決冲突

* 下拉文件
```
git pull origin master
```
* 编辑文件解决冲突
	```
	<<<<<<< HEAD
	# NI SHI WO

	# WO SHI NI

	=======
	# hello

	## this is
	>>>>>>> 07bc3732d82169c75b9d62ba3151deed5c68f4f6
	```

* 提交
```
git add .
git commit -m "test"
git push
```

## 分支合并

### 创建并导出一个分支

* 创建分支
	```
	$ git branch
	* master

	Administrator@WIN-KH7USRS3HHQ MINGW64 /f/vue (master)
	$ git branch testbranch

	Administrator@WIN-KH7USRS3HHQ MINGW64 /f/vue (master)
	$ git checkout testbranch
	Switched to branch 'testbranch'
	M       .idea/preferred-vcs.xml
	M       .idea/workspace.xml

	Administrator@WIN-KH7USRS3HHQ MINGW64 /f/vue (testbranch
	```
* 以上语句可以合并成为一句
	```
	git checkout -b iss1
	```

### 提交代码

	```
	git add .
	git commit -m "test"
	git push origin testbranch
	```
注：可以使用``git push --set-upstream origin testbranch``设置上行推送默认地址,如果做了改设置，可使用``git push``推送。

### 合并代码

* 切换到将要合并的分支
	```
	git checkout master
	```
* 合并分支
	```
	$ git merge testbranch
	Updating 0862265..0ff6c19
	Fast-forward
	.gitignore              |   2 +
	.idea/preferred-vcs.xml |   3 +-
	.idea/workspace.xml     | 150 +++++++++++++++++++++++++++++++++++++++---------
	examples/v-for.html     |  32 +++++++++++
	index.html              |   2 +
	5 files changed, 160 insertions(+), 29 deletions(-)
	create mode 100644 .gitignore
	create mode 100644 examples/v-for.html
	```
* 解决冲突
  使用下面命令查看冲突文件，手动编辑解决冲突，解决完冲突的文件使用``git add filename``命令标记为解决。
  ```
  git status 
  ```
  使用下面工具解决冲突，请注意，合并时mine指的你当前所处的分支。
  ```
  git mergetool
  ```
  
* 删除分支,``git branch -d branchname``

* 刪除远程分支,``git push origin --delete testbranch``


### 发布版本

git tag

git tag -d tagname

git log -n 1

git tag -a "v1.0.1" dad6772a3ba211453d2112ce2e4763f97b7414b1 -m "this is a test"


git push origin v1.0.1

效果演示：  
![](assets/markdown-img-paste-20170813182318179.png)




[返回](/readme.md)
