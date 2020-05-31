# css单独分离打包


## 简介

通常情况下，静态文件单独存放能够优化加载速度，本文介绍，如何使用mini-css-extract-plugin文件单独打包css文件（分离css文件）。

## 详细步骤


* 安装依赖包  


```bash 
# yarn add extract-text-webpack-plugin
# 该包单独打包
yarn add mini-css-extract-plugin

```

* 重新编写打包配置文件``webpack.config.js``   


```js 
const   path = require("path")
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const HTMLPlugin = require('html-webpack-plugin')
const webpack = require('webpack')
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const isDev = process.env.NODE_ENV === 'development'

const config ={
    target: "web",
    entry:  path.join(__dirname,'src/index.js'),
    output: {
        filename: 'bundle.[hash:8].js',
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
            // {// 添加这个json，解决如上的报错问题
            //     test: /\.scss$/,
            //     use: ['style-loader','css-loader', 'sass-loader']
            // },
            // {// 添加这个json，解决如上的报错问题
            //     //使用的use模式
            //     test: /\.css$/,
            //     use: ['style-loader','css-loader', 'sass-loader']
            // },
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
    config.module.rules.push({
        // test: /\.styl$/,
        test: /\.styl(us)?$/,
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
    })
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
        hot: true,
    }
    config.plugins.push(
        new webpack.HotModuleReplacementPlugin(),
        new webpack.NoEmitOnErrorsPlugin()
    )
}else{

    //生产模式的时候修改配置
    config.output.filename = '[name].[chunkhash:8].js'
    config.module.rules.push(
        {
            test: /\.styl/,
            use: [
                {
                    loader: MiniCssExtractPlugin.loader,
                    options: {
                        // publicPath:  path.join(__dirname,'dist'),
                        publicPath: (resourcePath, context) => {
                            return path.relative(path.dirname(resourcePath), context) + '/dist';
                        },
                    },
                },
                'css-loader',
                {
                    loader: "postcss-loader",
                    //使用前面生成的sourceMap
                    options: {
                        sourceMap: true
                    }
                },
                'stylus-loader',
            ],
        },
    )

    config.plugins.push(
        new MiniCssExtractPlugin({
            // Options similar to the same options in webpackOptions.output
            // all options are optional
            filename: '[name].[contentHash:8].css',
            chunkFilename: '[id].css',
            ignoreOrder: false, // Enable to remove warnings about conflicting order
        }),
    )
}


module.exports = config


```


