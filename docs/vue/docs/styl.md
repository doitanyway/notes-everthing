# 添加stylus支持

## 简介

在css样式开发中，css实际不太好模块化开发，为了能够模块化开发，我们期望引入预处理器styless。


## 详细步骤 

* 安装依赖

```bash 
yarn add stylus-loader  stylus
```


* ``webpack.config.js``添加预处理器  

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
                //使用的use模式
                test: /\.css$/,
                use: ['style-loader','css-loader', 'sass-loader']
            },
            {
                test: /\.styl$/,
                use: ['style-loader','css-loader', 'stylus-loader']
            },
            {
                test:/\.(gif|jpeg|jpg|png|svg)$/,
                use: [
                    {
                        loader: "url-loader",
                        options: {
                            //文件小于1024转移成为base64存储
                            limit: 1024,
                            name: '[name]-bbb.[ext]'
                        }
                    }
                ]

            }
        ]
    }
}
```


* 添加``src/assets/style/test-stylus.styl``样式文件   

```styl
body
  font-size: 10px
```

* ``src/index.js``入口文件中引入依赖  

```js
import  Vue from "vue"
import App from "./app.vue"
import "./assets/style/test.css"
import "./assets/image/bg.png"
import "./assets/style/test-stylus.styl"

const root = document.createElement("div")
document.body.appendChild(root)

new Vue({
    render: (h) => h(App)
}).$mount(root)
```


* 执行编译  

```bash 
yarn run build 
```

