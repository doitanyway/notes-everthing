# chart模板开发

本文为heml chart模板的介绍，重点介绍模板语言。

模板会生产k8s能够识别的资源文件，我们姜户介绍模板的结构、如何使用、如何写go template以及怎么调试.

* helm 模板语言；
* 使用values
* 使用templates


## chart template入门

本章我们将会创建第一个模板，然后该chart将会贯穿我们整篇文章。为了更好的入门我们先来了解一下helm chart 

### chart 

HELM chart文件格式如下：   

```yaml
mychart/
  Chart.yaml
  values.yaml
  charts/
  templates/
  ...
```

* templates文件夹是为了存储模板文件的，当tiller收到一个安装chart命令，它将会把template/文件夹下的所有文件发送给模板渲染引擎，然后把渲染后的结果送给k8s安装；
* values.yaml对于模板文件来说非常重要，他保存了chart中的默认值，这些值在安装或者升级的时候可以被重写；
*  Chart.yaml文件包含了chart的描述. 可以在chart内的模板文件访问该文件的属性，. The charts/文件夹可能包含其他的charts. 稍后我们将会在本教程中说明.


### 创建 CHART

这里我们创建一个 chart叫做mychart，然后我们在chart内创建一些temlate
```
$ helm create mychart
Creating mychart
```

* mychart/templates/ 一览 ，这里我们为了后面的练习先删除掉template下的文件： ``rm -rf templates/*.*``

```
* NOTES.txt: The “help text” for your chart. This will be displayed to your users when they run helm install.
*  deployment.yaml: A basic manifest for creating a Kubernetes deployment
*  service.yaml: A basic manifest for creating a service endpoint for your deployment
*  _helpers.tpl: A place to put template helpers that you can re-use throughout the chart
```

### 第一个模板

我们创建的第一个模板将会是 ConfigMap. 在K8S内,configmap通常用来存储配置数据.POD等资源来访问config map.


创建文件 mychart/templates/configmap.yaml:

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: mychart-configmap
data:
  myvalue: "Hello World"
```

* 安装查看  

```BASH
# 安装
nicks-MacBook-Pro:mychart nick$ helm install ./
NAME:   wrapping-spaniel
LAST DEPLOYED: Mon Sep 30 23:22:37 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME               DATA  AGE
mychart-configmap  1     0s

# 使用命令查看发布的chart
nicks-MacBook-Pro:mychart nick$ helm get wrapping-spaniel
...
---
# Source: mychart/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mychart-configmap
data:
  myvalue: "Hello World"
```

* 添加一个模板引用,修改文件configmap.yaml

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
```

* 执行命令 ``helm install ./  --debug --dry-run`` 测试，运行后生成的资源结果

```bash
nicks-MacBook-Pro:helm nick$ helm install ./mychart/ --debug --dry-run 
[debug] Created tunnel using local port: '51991'

[debug] SERVER: "127.0.0.1:51991"

[debug] Original chart version: ""
[debug] CHART PATH: /Users/nick/Desktop/study/helm/mychart

NAME:   ponderous-ibex
REVISION: 1
RELEASED: Mon Sep 30 23:32:50 2019
CHART: mychart-0.1.0
...
---
# Source: mychart/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: ponderous-ibex-configmap
data:
  myvalue: "Hello World"
```

> 上面的Release为一个内置的对象。后面我们会详细介绍对象的用法。我们Release.Name为发布名，上面为ponderous-ibex

## 内置对象

模板引擎将会把模板引用的内置对象替换成为对象的实际值，下面是一些内置对象的举例：

* Release: 该对象描述发布版本信息，该对象内部包含多个对象:
  * Release.Name: 发布名
  * Release.Time: 发布时间
  * Release.Namespace: 发布版本到哪一个namespace中（manifest可以重写该值） 
  * Release.Service: 发布服务的名字 (always Tiller).
  * Release.Revision: 发布版本号，该数字从1开始，升级之后自增.
  * Release.IsUpgrade: 如果该值为true,则该操作是升级或者回滚.
  * Release.IsInstall: 如果当前操作为安装则该值为true。

* Values: Values的值来自于values.yaml文件，默认Values对象为空.


* Chart: Chart上下文对象在 Chart.yaml文件中. Chart.yaml中的值将会被打包到该对象. 如 {{.Chart.Name}}-{{.Chart.Version}} 将会输出 mychart-0.1.0.

* Files: 该对象提供了chart内访所有非特殊文件的方法. （不能用它来访问templates文件）
  * Files.Get 通过文件名字获取文件的方法(.Files.Get config.ini)
  * Files.GetBytes 函数获取文件内容保存到bytes数组内（可以用来读取图片）。

* Capabilities: 该对象提供了k8s集群支持的容量信息.
  * Capabilities.APIVersions API版本
  * Capabilities.APIVersions.Has $version 判断某一API版本(e.g., batch/v1)或者某一资源(e.g., apps/v1/Deployment) 是否在K8S集群内支持.
  * Capabilities.KubeVersion 获取k8s版本. 值为: Major, Minor, GitVersion, GitCommit, GitTreeState, BuildDate, GoVersion, Compiler, 和 Platform.
  * Capabilities.TillerVersion 获取tailler版本. 值为: SemVer, GitCommit, and GitTreeState.
* Template: 包含当前执行的template的一些信息
  * Name: 当前template的namespace(e.g. mychart/templates/mytemplate.yaml)
  * BasePath:  The namespaced path to the templates directory of the current chart (e.g. mychart/templates).

如上的值在任何顶级的模板都可用，但是并不是每个地方都可用，我们后续将会详细介绍。

built-in values经常都是以大写字母开始，如果我们创建自己的names可以按自己的习惯来处理。

## Values 文件


* 修改values.yaml
```yaml
favorite:
  drink: coffee
  food: pizza
```

* 修改configmap.yaml文件，引用values 
```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ .Values.favorite.drink }}
  food: {{ .Values.favorite.food }}
```

* 执行命令查看创建结果  
```bash
nicks-MacBook-Pro:helm nick$ helm install --debug --dry-run ./
[debug] Created tunnel using local port: '56426'

[debug] SERVER: "127.0.0.1:56426"

[debug] Original chart version: ""
[debug] CHART PATH: /Users/nick/Desktop/study/helm

Error: no Chart.yaml exists in directory "/Users/nick/Desktop/study/helm"
nicks-MacBook-Pro:helm nick$ helm install --debug --dry-run ./mychart/
[debug] Created tunnel using local port: '56433'
.....

---
# Source: mychart/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: manageable-horse-configmap
data:
  myvalue: "Hello World"
  drink: coffee
  food: pizza
```

* 删除默认值 

如果我们需要删除一个默认值，可以在执行命令的时候设置Key的值为Null，这样helm将会合并命令传入的参数。 

如：    
```YAML
livenessProbe:
  httpGet:
    path: /user/login
    port: http
  initialDelaySeconds: 120
```

执行命令  ``helm install stable/drupal --set image=my-registry/drupal:0.1.0 --set livenessProbe.exec.command=[cat,docroot/CHANGELOG.txt] --set livenessProbe.httpGet=null``

合并后结果：

```YAML
livenessProbe:
  httpGet:
    path: /user/login
    port: http
  exec:
    command:
    - cat
    - docroot/CHANGELOG.txt
  initialDelaySeconds: 120
```

## 模板函数和管道


* 目前我们通过对象重新渲染模板，但是对象通常都是未经任何修改放在模板文件中，这样并不是最佳实践，如我们在引用一个string对象的时候我们期望能够有个双引号把该对象包含起来，这个时候我们可以使用模板函数quote，用法如下。

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ quote .Values.favorite.drink }}
  food: {{ quote .Values.favorite.food }}
```

> 模板方法用法``functionName arg1 arg2...``,如上使用了quote函数，传入的参数1为.Values.favorite.food


helm支持60多个模板函数，一些是[Go template language](https://godoc.org/text/template)定义的，大多其他的函数是[ Sprig template library](https://godoc.org/github.com/Masterminds/sprig)


* 管道，模板函数可以通过管道的方法引用(类似LINUX命令)，如下；  

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ .Values.favorite.drink | quote }}
  # 参数可传递
  food: {{ .Values.favorite.food | upper | quote }}
```

* 常用函数  
  * quote 双引号     {{ .Values.favorite.drink | quote }}
  * upper 大写  {{ .Values.favorite.food | upper  }}
  * repeat 重复多次 {{ .Values.favorite.drink | repeat 5 | quote }}
  * default 默认函数，参数未设置的时候默认值 {{ .Values.favorite.drink | default "tea" | quote }}
  * 运算符支持eq, ne, lt, gt, and, or, not，通常这些操作符号都和if条件一起用，如下：  

```YAML
{{/* include the body of this if statement when the variable .Values.fooString exists and is set to "foo" */}}
{{ if and .Values.fooString (eq .Values.fooString "foo") }}
    {{ ... }}
{{ end }}


{{/* include the body of this if statement when the variable .Values.anUnsetVariable is set or .values.aSetVariable is not set */}}
{{ if or .Values.anUnsetVariable (not .Values.aSetVariable) }}
   {{ ... }}
{{ end }}
```

## 流程控制  

helm中提供了如下流控制结构： 

* if/else 创建一个条件模块
* with 定义一个范围（？scope） 
* range, 提供一个for each循环

此外，helm还提供了如下几个方法声明模块块:

* define 在模板中定义一个新的名词模板
* template 引入一个名称模板
* block 定义一个特别的可填充的模板区域


### IF/ELSE

```YAML
{{ if PIPELINE }}
  # Do something
{{ else if OTHER PIPELINE }}
  # Do something else
{{ else }}
  # Default case
{{ end }}
```

* 如下情况会被认为是false
  * a boolean false
  * a numeric zero
  * an empty string
  * a nil (empty or null)
  * an empty collection (map, slice, tuple, dict, array)


* 如： 
```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ .Values.favorite.drink | default "tea" | quote }}
  food: {{ .Values.favorite.food | upper | quote }}
  {{ if and .Values.favorite.drink (eq .Values.favorite.drink "coffee") }}mug: true{{ end }}
```

* 上面一个列子，可读性不够，优化一下：  

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  drink: {{ .Values.favorite.drink | default "tea" | quote }}
  food: {{ .Values.favorite.food | upper | quote }}
  {{- if eq .Values.favorite.drink "coffee"}}
  mug: true
  {{- end}}
```
> 注意``{{-``代表忽略该语句前的空格，-后面有一个空格

### with 

其格式如下，用途类似于一个单独的IF没有ELSE的情况：

```yaml
{{ with PIPELINE }}
  # restricted scope
{{ end }}
```

* 如：
```YAML
 apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  {{- with .Values.favorite }}
  drink: {{ .drink | default "tea" | quote }}
  food: {{ .food | upper | quote }}
  {{- end }}
```

### RANGE

循环  

* 如： 
  * values.yaml
```YAML
pizzaToppings:
  - mushrooms
  - cheese
  - peppers
  - onions
```
  * template

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
  toppings: |-
    {{- range .Values.pizzaToppings }}
    - {{ . | title | quote }}
    {{- end }}
```

> toppings: |- 定义了一个多行string. 


```YAML
sizes: |-
    {{- range list "small" "medium" "large" }}
    - {{ . }}
    {{- end }}
```