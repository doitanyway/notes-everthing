# Node开发环境安装

## 安装node

在[官网](https://nodejs.org/download/release/v6.10.3/)下载node

### windows
* 点击执行安装node安装。

### LINUX

* 存放Node到对应目录（建议/usr/local/src/）
* 解压文件  

```
$ xz -d node-v6.10.1-linux-x64.tar.xz
$ tar -xvf node-v6.10.1-linux-x64.tar
```

* 使用root用户设置环境变量``vi /etc/profile``，文件末尾加上


```
# node （注释作用）
export NODE_HOME=/usr/local/src/node-v6.10.3-linux-x64
export PATH=$PATH:$NODE_HOME/bin  
export NODE_PATH=$NODE_HOME/lib/node_modules 
```

* :wq （保存并退出）
* source /etc/profile （使配置文件生效）
* 验证是否安装好

```
[root@bogon node-v8.9.1-linux-x64]# node -v
v8.9.1
[root@bogon node-v8.9.1-linux-x64]# npm -v
5.5.1
```


## 安装cnpm

执行命令:
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```


## cnpm 命令简要说明
### 安装模块
从 registry.npm.taobao.org 安装所有模块. 当安装的时候发现安装的模块还没有同步过来, 淘宝 NPM 会自动在后台进行同步, 并且会让你从官方 NPM registry.npmjs.org 进行安装. 下次你再安装这个模块的时候, 就会直接从 淘宝 NPM 安装了.
```
$ cnpm install [name]
```
### 同步模块

直接通过 sync 命令马上同步一个模块, 只有 cnpm 命令行才有此功能:
```
$ cnpm sync connect
```
当然, 你可以直接通过 web 方式来同步: /sync/connect
```
$ open https://npm.taobao.org/sync/connect
```
### 其它命令
支持 npm 除了 publish 之外的所有命令, 如:

$ cnpm info connect



[返回](./readme.md)
