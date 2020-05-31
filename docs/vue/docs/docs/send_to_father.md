# 子组件向父组件传值


* 子组件中调用emit方法：  
```js 
this.$emit('del',this.todo.id)
```


* 父组件中监听该方法：  

```vue
<template>
    <section class="real-app">
    <!-- 1. @del 监听emit del方法,监听到了之后给 deleteTodo处理 -->
        <Item :todo="todo"
                v-for="todo in todos"
                :key="todo.id"
                @del="deleteTodo"
        ></Item>
    </section>
</template>

<script>
    import Item from './item.vue'
    export default {
        name: "todo",
        data() {
            return {
                todos: [],
                filter: 'all'
            }
        },
        components: {
            Item
        },
        methods: {
            //2. 处理函数
            deleteTodo(id){
                this.todos.splice(this.todos.findIndex(todo => todo.id === id),1)
            }
        }
    }
```
