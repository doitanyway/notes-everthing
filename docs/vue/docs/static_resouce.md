# 加载静态资源


## 简介

本文承接上一个项目 [创建一个简单的vue js项目](create_vue.md),在该项目 基础上创建一个完整



## 详细步骤

* 安装依赖

```bash 
yarn add style-loader url-loader file-loader
```

* ``webpack.config.js``文件内添加css和图片文件的预处理器  

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

* 添加图片文件到目录``src/assets/image/``下 ,[下载地址](https://github.com/Amy0904/vue-webpack-todo/tree/master/src/assets/images) 


* 添加css文件 ``src/assets/style/test.css``

```bash
body{
    color: red;
    background-image: url('../image/unChecked.svg');
}
```

* 重新编译文件  

```bash 
yarn run build 
```