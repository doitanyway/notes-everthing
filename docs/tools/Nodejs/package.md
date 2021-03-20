# package


## 可移动到devDependencies的依赖

* ``@types/...`` 依赖是ts的类型声明
* node-sass是sass的预处理器
* react-scripts，是create-react-script自带的一些工具
* ``typescript`` ts编译器



* peerDependencies该包必须依赖安装如下2版本module

```json
  "peerDependencies": {
    "react": ">=17.0.0",
    "react-dom": ">=17.0.0"
  },
```