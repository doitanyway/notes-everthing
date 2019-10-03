# 名称模板

本问介绍define, template, 和 block，同时我们也会介绍include的特殊用途。

> template是全局的，所以顶级的template命名需要特别注意不能重复。


## template函数

### 语法

* 声明语法

```YAML
{{ define "MY.NAME" }}
  # body of template here
{{ end }}
```

* 如： 

```YAML
{{- define "mychart.labels" }}
  labels:
    generator: helm
    date: {{ now | htmlDate }}
{{- end }}
```

* 使用如下template文件 
```YAML
{{- define "mychart.labels" }}
  labels:
    generator: helm
    date: {{ now | htmlDate }}
{{- end }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
  {{- template "mychart.labels" }}
data:
  myvalue: "Hello World"
```

* 安装将会得到如下对象  
```YAML
apiVersion: v1
data:
  myvalue: Hello World
kind: ConfigMap
metadata:
  creationTimestamp: 2019-10-03T00:45:29Z
  labels:
    date: 2019-10-03
    generator: helm
  name: alternating-marsupial-configmap
  namespace: default
  resourceVersion: "770419"
  selfLink: /api/v1/namespaces/default/configmaps/alternating-marsupial-configmap
  uid: 18ff3a6b-e577-11e9-bd31-025000000001
```

* 我们可以在模板文件下面新建一个_helpers.tpl文件,把对应的template块转移到这里去，让所有的template文件都可以调用。
```YAML
{{/* 这是该函数的注释 */}}
{{- define "mychart.labels" }}
  labels:
    generator: helm
    date: {{ now | htmlDate }}
{{- end }}
```

* 如果在函数内，我们需要使用一些内置对象，我们在引用的时候需要设置scope ,只需要加一个.即可，如: ``{{- template "mychart.labels" . }}`` 


```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
  {{- template "mychart.labels" . }}
```

## include 函数


* define  函数
```YAML
{{- define "mychart.app" -}}
app_name: {{ .Chart.Name }}
app_version: "{{ .Chart.Version }}+{{ .Release.Time.Seconds }}"
{{- end -}}
```

* 引用  
```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
  labels:
    {{- include "mychart.app" . | nindent 4 }}
data:
  myvalue: "Hello World"
  {{- range $key, $val := .Values.favorite }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
  {{- include "mychart.app" . | nindent 2 }}
```

> nindent将会指定缩进空格个数