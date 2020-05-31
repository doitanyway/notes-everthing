# 数据样式绑定案例


```vue
<template>
<!-- 2. 根据数据的值决定绑定些什么样子的样式  -->
    <div :class="['todo-item',todo.completed ?'completed':'' ]">
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