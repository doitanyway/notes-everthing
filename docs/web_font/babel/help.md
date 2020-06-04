#  babel 


## 简单使用

### 安装babel 


```bash 
# 
mkdir test & cd test 
# 安装babel 包
yarn add @babel/core @babel/cli @babel/preset-env -D
# 告警提示该版本低所以升级
# yarn add chokidar -D
```


### 添加build命令   

```json 
{
  "license": "MIT",
  "dependencies": {},
  "scripts": {
    "build": "babel src -d dist"
  },
  "devDependencies": {
    "@babel/cli": "^7.10.1",
    "@babel/core": "^7.10.2",
    "@babel/preset-env": "^7.10.2",
    "chokidar": "^3.4.0"
  }
}

```

### ``src/test.js``准备ES6文件  

```js
"use strict";

var abc = "test";
console.log(abc);
```

## 编译

执行该语句之后将会生成``dist/test.js``文件 


```bash 
yarn run build 
```

* 编译后js文件如下

```js
"use strict";

var abc = "test";
console.log(abc);
```