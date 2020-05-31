#   添加webpack-dev-server支持


## 简介

webpack-dev-server为我们在线开发调试前端工程提供了一个很好的解决方案，本节讲解如何在上一节代码基础上配置webpack-dev-server支持。

基础代码参考[添加stylus支持](styl.md),使用分支``02stylus``


```bash 
# 服务器开发方便  
yarn add webpack-dev-server
# corss-env用来在不同环境中访问不同的变量,因为MAC和WINDOWS环境变量语法不一样所以才需要安装
yarn add cross-env
#
yarn add html-webpack-plugin
```



* ``package.json``添加webpack-dev-server相关命令，及其环境变量配置   

```bash 
{
  "name": "vue",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "build": "cross-env NODE_ENV=production webpack --config  webpack.config.js",
    "dev": "cross-env NODE_ENV=development webpack-dev-server --config  webpack.config.js"
  },
  "license": "MIT",
  "dependencies": {
    "chokidar": "^3.4.0",
    "cross-env": "^7.0.2",
    "css-loader": "^3.5.3",
    "file-loader": "^6.0.0",
    "html-webpack-plugin": "^4.3.0",
    "node-sass": "^4.14.1",
    "sass-loader": "^8.0.2",
    "style-loader": "^1.2.1",
    "stylus": "^0.54.7",
    "stylus-loader": "^3.0.2",
    "url-loader": "^4.1.0",
    "vue": "^2.6.11",
    "vue-loader": "^15.9.2",
    "vue-template-compiler": "^2.6.11",
    "webpack": "^4.43.0",
    "webpack-dev-server": "^3.11.0"
  },
  "devDependencies": {
    "webpack-cli": "^3.3.11"
  }
}

```



* ``webpack.config.js``判断不同环境，做不同配置，添加development环境下的配置  
```js 
const   path = require("path")
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const HTMLPlugin = require('html-webpack-plugin')
const webpack = require('webpack')

const isDev = process.env.NODE_ENV === 'development'

const config ={
    target: "web",
    entry:  path.join(__dirname,'src/index.js'),
    output: {
        filename: 'bundle.js',
        path: path.join(__dirname,'dist')
    },
    plugins: [
        new VueLoaderPlugin(),
        //vue webpack会根据不同的环境区分打包
        new webpack.DefinePlugin({
            'process.env':{
                NODE_ENV: isDev? '"development"' :'"production"'
            }
        }),
        new HTMLPlugin()
    ],
    mode: process.env.NODE_ENV,
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


if (isDev){
    config.devtool = '#cheap-module-eval-source-map'
    config.devServer = {
        port: 8000,
        host: '0.0.0.0',
        //有错误显示到网页上
        overlay: {
            errors: true
        },
        //没有的路由默认跳转到一个页面去
        // historyFallback:{
        //
        // },
        //启动webpack-dev-server的时候自动帮助打开浏览器
        open: true,
        //更改内容之后热加载,HotModuleReplacementPlugin, NoEmitOnErrorsPlugin
        // hot: true,
    }
    // config.plugins.push(
    //     new webpack.HotModuleReplacementPlugin()
    //     new webpack.NoEmitOnErrorsPlugin()
    // )
}
module.exports = config
```



* 尝试运行webpack-dev-server  

```bash  
yarn run dev 
```