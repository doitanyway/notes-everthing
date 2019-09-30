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

* Release: This object describes the release itself. It has several  objects inside of it:
  * Release.Name: The release name
  * Release.Time: The time of the release
  * Release.Namespace: The namespace to be released into (if the manifest doesn’t override)
  * Release.Service: The name of the releasing service (always Tiller).
  * Release.Revision: The revision number of this release. It begins at 1 and is incremented for each helm upgrade.
  * Release.IsUpgrade: This is set to true if the current operation is an upgrade or rollback.
  * Release.IsInstall: This is set to true if the current operation is an install.

* Values: Values passed into the template from the values.yaml file and from user-supplied files. By default, Values is empty.


* Chart: The contents of the Chart.yaml file. Any data in Chart.yaml will be accessible here. For example {{.Chart.Name}}-{{.Chart.Version}} will print out the mychart-0.1.0.

* Files: This provides access to all non-special files in a chart. While you cannot use it to access templates, you can use it to access other files in the chart. See the section Accessing Files for more.
  * Files.Get is a function for getting a file by name (.Files.Get config.ini)
  * Files.GetBytes is a function for getting the contents of a file as an array of bytes instead of as a string. This is useful for things like images.

* Capabilities: This provides information about what capabilities the Kubernetes cluster supports.
  * Capabilities.APIVersions is a set of versions.
  * Capabilities.APIVersions.Has $version indicates whether a version (e.g., batch/v1) or resource (e.g., apps/v1/Deployment) is available on the cluster. Note, resources were not available before Helm v2.15.
  * Capabilities.KubeVersion provides a way to look up the Kubernetes version. It has the following values: Major, Minor, GitVersion, GitCommit, GitTreeState, BuildDate, GoVersion, Compiler, and Platform.
  * Capabilities.TillerVersion provides a way to look up the Tiller version. It has the following values: SemVer, GitCommit, and GitTreeState.
* Template: Contains information about the current template that is being executed
  * Name: A namespaced filepath to the current template (e.g. mychart/templates/mytemplate.yaml)
  * BasePath: The namespaced path to the templates directory of the current chart (e.g. mychart/templates).

The values are available to any top-level template. As we will see later, this does not necessarily mean that they will be available everywhere.

The built-in values always begin with a capital letter. This is in keeping with Go’s naming convention. When you create your own names, you are free to use a convention that suits your team. Some teams, like the Helm Charts team, choose to use only initial lower case letters in order to distinguish local names from those built-in. In this guide, we follow that convention.

## Values 文件