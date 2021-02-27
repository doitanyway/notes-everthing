# use-interval-定时 

## 简介

在react中使用定时函数``setinterval``总有一些蛋蛋的忧伤，state不更新，表现总是不是咱们想的那样。use-interval封装了了setinnterval函数，帮助使用定时函数


## 安装依赖


```bash 
# npm install --save use-interval
yarn add use-interval
```


## 使用

* 例子

```js
import * as React from 'react'
 
import useInterval from 'use-interval'
 
const Example = () => {
  let [count, setCount] = React.useState(0);
 
  useInterval(() => {
    // Your custom logic here
    setCount(count + 1);
  }, 1000);
 
  return <h1>{count}</h1>;
}
```

* 参数 

```js
// TypeScript Declaration
useInterval(
  callback: () => void,
  delay: number,
  immediate?: boolean /* called when mounted if true */
)

```



[源码](https://github.com/Hermanya/use-interval/blob/master/src/index.tsx)
