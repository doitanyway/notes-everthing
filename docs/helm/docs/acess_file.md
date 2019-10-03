# template中访问文件



## 简单用法

如我们有一个configmap，该文件中的data来自于另外三个文件：

* mychart/目录下创建三个配置文件：  
  * config1.toml:  
```
message = Hello from config 1
```
  * config2.toml:  
```
message = This is config 2
```

  * config3.toml:   
```
message = Goodbye from config 3
```

* 应用配置文件  
```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- $files := .Files }}
  {{- range list "config1.toml" "config2.toml" "config3.toml" }}
  {{ . }}: |-
    {{ $files.Get . }}
  {{- end }}
```
> 如上代码: 
> 定义了一个$files表里来保存文件内容
> 使用 list函数去遍历三个文件
> ``{{ . }}: |-``输出每个文件的文件名
> {{ $files.Get . }} 获取文件内容

* 执行查看输出:``helm install ./ --debug --dry-run ``


## 使用文件目录加载文件

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: conf
data:
  {{- (.Files.Glob "foo/*").AsConfig | nindent 2 }}
---
apiVersion: v1
kind: Secret
metadata:
  name: very-secret
type: Opaque
data:
  {{- (.Files.Glob "bar/*").AsSecrets | nindent 2 }}
```