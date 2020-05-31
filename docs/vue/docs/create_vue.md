# 创建一个简单的vue js项目


## 简介

在vue的官网上通常使用vue-cli创建打包项目，但是在实际企业级项目中vue-cli通常满足不了实际需求，因此需要更深入的打包定制。本文讲解如何创建一个工程并且使用webpack打包。

本文假设读者已经安装好了nodejs,yarn。


## 详细步骤 

*  

```bash 
mkdir vue-demo  && cd vue-demo
# 初始化项目，创建package.json文件
yarn init 
# 安装相关依赖 ,实际安装依赖可以根据情况安装
yarn add webpack vue vue-loader
yarn add chokidar 
yarn add vue-template-compiler
yarn add style-loader css-loader sass-loader
yarn add node-sass 

```

* 创建应用模板文件``src/app.vue``

```vue 
<template>
<div id="test">
    {{text}}
</div>
</template>

<script>
    export default {
        data(){
            return {
                text: 'abc'
            }
        }
    }

</script>
<style>
    #test{
        color: red;
    }
</style>
```

* 创建入口文件``src/index.js``

```js
import  Vue from "vue"
import App from "./app.vue"

const root = document.createElement("div")
document.body.appendChild(root)

new Vue({
    render: (h) => h(App)
}).$mount(root)
```

* 创建打包配置文件 ``webpack.config.js``

```js
const   path = require("path")
const VueLoaderPlugin = require('vue-loader/lib/plugin');

module.exports ={
    entry:  path.join(__dirname,'src/index.js'),
    output: {
        filename: 'bundle.js',
        path: path.join(__dirname,'dist')
    },
    plugins: [
        new VueLoaderPlugin()
    ],
    mode: "development",
    module: {
        rules: [
            {
                //.vue结尾的使用vue-loader来处理
                test: /.vue$/,
                loader: 'vue-loader'
            },
            {// 添加这个json，解决如上的报错问题
                test: /\.scss$/,
                use: ['style-loader','css-loader', 'sass-loader']
            },
            {// 添加这个json，解决如上的报错问题
                test: /\.css$/,
                use: ['style-loader','css-loader', 'sass-loader']
            }
        ]
    }
}
```

* 修改package.json，添加编译``build``命令  

```json
{
  "name": "vue",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "build": "webpack --config  webpack.config.js"
  },
  "license": "MIT",
  "dependencies": {
    "chokidar": "^3.4.0",
    "css-loader": "^3.5.3",
    "node-sass": "^4.14.1",
    "sass-loader": "^8.0.2",
    "style-loader": "^1.2.1",
    "vue": "^2.6.11",
    "vue-loader": "^15.9.2",
    "vue-template-compiler": "^2.6.11",
    "webpack": "^4.43.0"
  },
  "devDependencies": {
    "webpack-cli": "^3.3.11"
  }
}

```

* 执行编译操作 

```bash 
# 执行该命令，将会在dist目录下生成一个bundle.js文件作为输出文件
yarn run build 

# 完成项目分支 create_vue
```


## 常见错误

* 依赖包缺少或者依赖包版本不对  

```bash 
yarn remove [packagename]
# 安装指版本包
yarn add [packagename]@[version]
# 安装指定包
yarn add [packagename]

```

