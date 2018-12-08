# Data Methods

存储以及获取数据：  
```js
// Storing and retrieving data related to an element.
 
$( "#myDiv" ).data( "keyName", { foo: "bar" } );
 
$( "#myDiv" ).data( "keyName" ); // Returns { foo: "bar" }
```

任何类型的数据都可以被存在元素中，article中的.data()将会用来存储引用到其他元素。  
