# npm_link

## 简介

当我们制作一个module库之后，如果需要本地测试，则可以通过npm link来使用

## 详细步骤


* 被使用的组件的工程``vikingship``执行命令,创建一个软连接，连接到代码,如下会提示在引用的项目中如何输入命令
  
```bash 
# 
# npm link 
nick@nicks-MacBook-Pro  ~/Desktop/study/react/vikingship   master  yarn link 
yarn link v1.22.10
warning package.json: No license field
warning package.json: No license field
success Registered "vikingship".
info You can now run `yarn link "vikingship"` in the projects where you want to use this package and it will be used instead.
✨  Done in 0.06s.
```

* 被使用组件工程``vikingship``，修改package.js 添加

```json
  "main": "build/index.js",
  "module": "build/index.js",
  "types": "build/index.d.ts",
```


* 使用组件的工程``vikingtest``执行命令关联软连接  
```bash 
# vikingship 是之前被使用组件的名字
# npm link vikingship
yarn link  vikingship
```

* 修改使用组件的工程``vikingtest``中package.json文件添加依赖

```json
  "dependencies": {
    ......
    "vikingship": "^0.1.2"
```



* 修改使用组件的工程``vikingtest``index.tsx，加入css依赖  

```js
import 'vikingship/build/index.css'

```

* 使用组件  

```js 
import React from 'react';
import './App.css';
import { Button } from 'vikingship'
import { ButtonType } from 'vikingship/build/components/Button/button';

function App() {
  return (
    <div >
      <Button btnType={ButtonType.Primary}>hello this is a new projects</Button>
    </div>
  );
}

export default App;

```