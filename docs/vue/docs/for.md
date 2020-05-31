# 循环案例


```vue 
<template>
    <div class="helper">
        <span class="tabs">
        <!-- 循环的生成3个span  -->
            <span
            v-for="state in states"
            :key="state"
            class="[state,filter === state ? 'actived': '']"
            >
                {{state}}
            </span>
        </span>
    </div>
</template>
```