# ts-deepcopy-深度拷贝

## 简介

[deepcopy](https://www.npmjs.com/package/ts-deepcopy)是ts下的深度拷贝函数，当一个对象用该函数拷贝时，将会完全拷贝创造出一个新的对象


## 安装依赖 

```bash 
yarn add ts-deepcopy
# 
# npm install ts-deepcopy
```

## 使用 

```js 
interface I1 {
    a: string,
    b: {
        ba: string,
        bb: string
    }
}
 
let master:I1 = {
    a: "a",
    b: {
        ba: "ba",
        bb: "bb"
    }
};
let copied:I1 = deepcopy<I1>(master);
 
copied.b.ba = "baba";
 
console.log(master.b.ba);   // => "ba"
console.log(copied.b.ba);   // => "baba"
```

