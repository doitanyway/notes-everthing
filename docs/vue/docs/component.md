# 组件的使用


## 简介

* 本文介绍了组件的基本结构
* 组件如何嵌套
* 父组件如何传递值给子组件

## 组件的结构  

* 组件结构如下例代码所示，包含了三个模块，template（模板模块，定义了页面内容）、script（js模块，定义数据和逻辑）、style（样式模块，定义显示格式）

```vue
<template>
    <div id="app">
        <div id="cover"></div>
        <Header></Header>
    </div>
</template>

<script>
    import Header from './todo/header.vue'

    export default {
        components: {
            Header,
        },
        data() {
            return {
                text: 'abc'
            }
        }
    }
</script>
<style lang="stylus" scoped>
    #app {
    
    }
</style>

```


## 组件嵌套

1个组件如果要嵌套到另外一个组件中去，需要有三个步骤 

1. script中导入需要嵌套的组件，并声明组件  

```vue
<script>
// 1.导入
    import Header from './todo/header.vue'
    export default {
        components: {
          // 2.声明
            Header,
        },
        data() {
            return {
                text: 'abc'
            }
        }
    }
</script>
```


## 父传值给子

* 在父组件中定义要传递的值 

```vue
<template>
  ......
  //1.把data中的todo 的值传递给子组件Item
  <Item :todo="todo"></Item>
  ......
</template>
<script>
    import Item from './item.vue'
    export default {
        data() {
            return {
              //定义值
                todo: {
                    id: 0,
                    content: '刷牙',
                    completed: false
                }
            }
        },
    }
</script>
```

* 在子组件中接收值 

```vue 
<template>
<!-- 2.使用传递进来的值 -->
    <div :class="['todo-item',todo.completed ?'completed':'' ]">
        <label >{{todo.content}}</label>
    </div>
</template>
<script>
    export default {
        name: "item",
        //1.接收值，定义类型，说明是否必须
        props:{
            todo:{
                type: Object,
                required: true
            }
        }
    }
</script>
```

