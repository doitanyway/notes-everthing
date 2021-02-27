# npmrc

``.npmrc``文件用来指定仓库的地址。


## 存放位置  

* 项目根目录，此时该配置在项目内生效 
* 用户根目录：win: ``C:\Users\[username]``,linux: ``~/``,此时对该用户生效 


## 文件内容 

* 简单内容 

```
registry=https://registry.npm.taobao.org/
```

* 部分包指定下载地址 

```
@angular:registry=https://registry.npm.taobao.org/
@angularclass:registry=https://registry.npm.taobao.org/
@ngtools:registry=https://registry.npm.taobao.org/
@ng-bootstrap:registry=https://registry.npm.taobao.org/
@types:registry=https://registry.npm.taobao.org/
@ionic:registry=https://registry.npm.taobao.org/
@ionic-native:registry=https://registry.npm.taobao.org/
@ngrx:registry=https://registry.npm.taobao.org/
@vue:registry=https://registry.npm.taobao.org/
phantomjs_cdnurl=http://npm.taobao.org/mirrors/phantomjs
chromedriver_cdnurl=https://npm.taobao.org/mirrors/chromedriver
sass-binary-site=http://npm.taobao.org/mirrors/node-sass
sqlite3_binary_host_mirror="https://foxgis.oss-cn-shanghai.aliyuncs.com/"
profiler_binary_host_mirror="https://npm.taobao.org/mirrors/node-inspector/"
electron_mirror="https://npm.taobao.org/mirrors/electron/"
ng:registry=https://registry.npm.taobao.org/
strict-ssl=false
registry=https://registry.npmjs.org/
home=https://www.npmjs.org
msvs_version=2017

```