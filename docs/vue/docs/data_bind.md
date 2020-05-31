# 数据双向绑定

```vue 
<template>
<!-- 2. v-model="todo.completed"   语句和数据双向绑定，选中或者不选中 -->
    <div>
        <input
                type="checkbox"
                class="toggle"
                v-model="todo.completed"
        >
        <label >{{todo.content}}</label>
    </div>
</template>

<script>
    export default {
        name: "item",
        // 1.定义数据
        data() {
            return {
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