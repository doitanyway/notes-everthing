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
## 配置镜像源

```bash 
# 使用taobao镜像
npm config set registry https://registry.npm.taobao.org
# 使用官方镜像
npm config set registry https://registry.npmjs.org
# 查看镜像源

```

## 其他

如果需要安装gitbook请移步[git说明](http://58.250.204.146:6002/fangle/notes-everthing/blob/master/tools/git/readme.md)



[返回](./readme.md)
