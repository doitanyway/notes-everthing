# 配置vue jsx写法以及postcss


##  简介 

本文介绍如何支持vue jsx 和postcss 

* vue jsx
* postcss： 在css编译好了之后再做一轮处理让css对各种浏览器的支持更好  

03webpack-dev-server


## 详细步骤


* 安装依赖  

```bash 
yarn add postcss-loader autoprefixer babel-loader babel-core
yarn add babel-preset-env babel-plugin-transform-vue-jsx 
yarn add @babel/core babel-helper-vue-jsx-merge-props 
```


* ``postcss.config.js``配置postcss  

```js 
const autoprefixer = require('autoprefixer')

//css编译完成之后再通过postcss来编译优化代码，使其浏览器兼容性更好
module.exports ={
    plugins : [
        autoprefixer()
    ]
}
```


* ``.babelrc``配置babel 

```json
{
  "presets": [
    "env"
  ],
  "plugins": [
    "transform-vue-jsx"
  ]
}
```

* ``webpack.config.js``为jsx文件和styl文件添加对应的loader 

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
            {
                test: /.jsx$/,
                loader: 'babel-loader'
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
                use: [
                    'style-loader',
                    'css-loader',
                    {
                        loader: "postcss-loader",
                        //使用前面生成的sourceMap
                        options: {
                            sourceMap: true
                        }
                    },
                    'stylus-loader'
                ]
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


* 执行程序  

```bash 
yarn run dev 

# 提交保存代码,新建一个分支 04postcss 保存这个版本代码   
git add . 
git commit -m "[add] postcss" 
git checkout -b 04postcss  
git checkout master 

```