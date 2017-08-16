
# 安装node
在[官网](https://nodejs.org/en/)下载node安装。

# 安装cnpm
执行命令:
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

# cnpm 命令简要说明
## 安装模块
从 registry.npm.taobao.org 安装所有模块. 当安装的时候发现安装的模块还没有同步过来, 淘宝 NPM 会自动在后台进行同步, 并且会让你从官方 NPM registry.npmjs.org 进行安装. 下次你再安装这个模块的时候, 就会直接从 淘宝 NPM 安装了.
```
$ cnpm install [name]
```
## 同步模块

直接通过 sync 命令马上同步一个模块, 只有 cnpm 命令行才有此功能:
```
$ cnpm sync connect
```
当然, 你可以直接通过 web 方式来同步: /sync/connect
```
$ open https://npm.taobao.org/sync/connect
```
## 其它命令
支持 npm 除了 publish 之外的所有命令, 如:

$ cnpm info connect



[返回](./readme.md)
