# useTimeoutFn


## 简介

超过一段时间之后自动调用一个函数，在调用之前可以取消。

## 安装依赖

```bash 
# npm i react-use
yarn add react-use
```

## 使用

```ts
import React, { useCallback } from 'react';

import { useTimeoutFn } from 'react-use';

function App() {

  const [state, setState] = React.useState('Not called yet');

  function fn() {
    setState(`called at ${Date.now()}`);
  }

  const [isReady, cancel, reset] = useTimeoutFn(fn, 5000);
  const cancelButtonClick = useCallback(() => {
    if (isReady() === false) {
      cancel();
      setState(`cancelled`);
    } else {
      reset();
      setState('Not called yet');
    }
  }, []);

  const readyState = isReady();

  return (
    <div>
      <div>{readyState !== null ? 'Function will be called in 5 seconds' : 'Timer cancelled'}</div>
      <button onClick={cancelButtonClick}> {readyState === false ? 'cancel' : 'restart'} timeout</button>
      <br />
      <div>Function state: {readyState === false ? 'Pending' : readyState ? 'Called' : 'Cancelled'}</div>
      <div>{state}</div>
    </div>
  );
}

export default App;

```


[源码](https://github.com/streamich/react-use/blob/master/src/useTimeoutFn.ts)