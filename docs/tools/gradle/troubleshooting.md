# troubleshooting

## 编码 GBK 的不可映射字符

提示：
> “警告：编码 GBK 的不可映射字符”


原因是因为代码中中文注释的缘故,只需按如下方式修改``build.gradle``设置编码即可

```
//编译groovy代码时采用 UTF-8
tasks.withType(GroovyCompile) {   
    groovyOptions.encoding = "MacRoman"   
} 
```

```
//编译JAVA文件时采用UTF-8
tasks.withType(JavaCompile) {
options.encoding = "UTF-8"
}
```

```
//如果生成javadoc出现编码问题添加
javadoc {
    options{
        encoding "UTF-8"
        charSet 'UTF-8'
        author true
        version true
        links "http://docs.oracle.com/javase/7/docs/api"
        title "这里写文档标题"
    }
}
```

