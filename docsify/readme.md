# docsify

## 快速开始

* 安装
```
cnpm i docsify-cli -g
```
* 初始化
```
docsify init ./docs
``` 

* 写内容
初始化完成之后，能够在``doc``目录下找到以下文件：

| 文件       | 说明                                                                                                                                                                   |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| index.html | 入口文件                                                                                                                                                               |
| README.md  | 首页                                                                                                                                                                   |
| .nojekyll  | prevents GitHub Pages from ignoring files that begin with an underscore You can easily update the documentation in ./docs/README.md, of course you can add more pages. |

 

* 预览网站
运行``docsify serve``预览网站http://localhost:3000.

docsify serve docs
For more use cases of docsify-cli, head over to the docsify-cli documentation.