# chart指引

chart可以用来描述一个简单的应用，也可以用来描述一个复杂的应用（如包含Http server,db,caches等等）

chart有特定的文件目录和文件结构。

本文介绍chart的格式，并且一步一步介绍如何使用helm创建chart。


## 文件结构

chart包含在一个文件夹中，该文件夹名既为chart的名字，如一个chart描述WordPress，则其应该被存储在  ``wordpress/``文件夹内。  
文件结构如下：  

```BASH
wordpress/
  Chart.yaml          # A YAML file containing information about the chart
  LICENSE             # OPTIONAL: A plain text file containing the license for the chart
  README.md           # OPTIONAL: A human-readable README file
  requirements.yaml   # OPTIONAL: A YAML file listing dependencies for the chart
  values.yaml         # The default configuration values for this chart
  charts/             # A directory containing any charts upon which this chart depends.
  templates/          # A directory of templates that, when combined with values,
                      # will generate valid Kubernetes manifest files.
  templates/NOTES.txt # OPTIONAL: A plain text file containing short usage notes
```

### Chart.yaml

* 该文件是必须文件，格式如下：

```yaml
apiVersion: The chart API version, always "v1" (required)
name: The name of the chart (required)
version: A SemVer 2 version (required)
kubeVersion: A SemVer range of compatible Kubernetes versions (optional)
description: A single-sentence description of this project (optional)
keywords:
  - A list of keywords about this project (optional)
home: The URL of this project's home page (optional)
sources:
  - A list of URLs to source code for this project (optional)
maintainers: # (optional)
  - name: The maintainer's name (required for each maintainer)
    email: The maintainer's email (optional for each maintainer)
    url: A URL for the maintainer (optional for each maintainer)
engine: gotpl # The name of the template engine (optional, defaults to gotpl)
icon: A URL to an SVG or PNG image to be used as an icon (optional).
appVersion: The version of the app that this contains (optional). This needn't be SemVer.
deprecated: Whether this chart is deprecated (optional, boolean)
tillerVersion: The version of Tiller that this chart requires. This should be expressed as a SemVer range: ">2.0.0" (optional)
```

### chart依赖

chart可能依赖于其他charts，对于依赖关系，可以通过``requirements.yaml``配置，也可以通过``charts/``文件管理 


### template文件

template文件遵循Go templates标准，如下是一个例子  

```YAML
apiVersion: v1
kind: ReplicationController
metadata:
  name: deis-database
  namespace: deis
  labels:
    app.kubernetes.io/managed-by: deis
spec:
  replicas: 1
  selector:
    app.kubernetes.io/name: deis-database
  template:
    metadata:
      labels:
        app.kubernetes.io/name: deis-database
    spec:
      serviceAccount: deis-database
      containers:
        - name: deis-database
          image: {{.Values.imageRegistry}}/postgres:{{.Values.dockerTag}}
          imagePullPolicy: {{.Values.pullPolicy}}
          ports:
            - containerPort: 5432
          env:
            - name: DATABASE_STORAGE
              value: {{default "minio" .Values.storage}}
```

### 预定义Values

Values可通过values.yaml文件或者是--set标志提供，在模板中可通过.Values对象访问。但是仍然有一些预定义的value可以在template中访问。

如下的预定义values可以在template中被访问，且不能覆盖；


* Release.Name: The name of the release (not the chart)
* Release.Time: The time the chart release was last updated. This will match the Last Released time on a Release object.
* Release.Namespace: The namespace the chart was released to.
* Release.Service: The service that conducted the release. Usually this is Tiller.
* Release.IsUpgrade: This is set to true if the current operation is an upgrade or rollback.
* Release.IsInstall: This is set to true if the current operation is an install.
* Release.Revision: The revision number. It begins at 1, and increments with each helm upgrade.
* Chart: The contents of the Chart.yaml. Thus, the chart version is obtainable as Chart.Version and the maintainers are in Chart.Maintainers.
* Files: A map-like object containing all non-special files in the chart. This will not give you access to templates, but will give you access to additional files that are present (unless they are excluded using .helmignore). Files can be accessed using {{index .Files "file.name"}} or using the {{.Files.Get name}} or {{.Files.GetString name}} functions. You can also access the contents of the file as []byte using {{.Files.GetBytes}}
* Capabilities: A map-like object that contains information about the versions of Kubernetes ({{.Capabilities.KubeVersion}}, Tiller ({{.Capabilities.TillerVersion}}, and the supported Kubernetes API versions ({{.Capabilities.APIVersions.Has "batch/v1")


### value文件

values文件的格式为yaml,chart可以包含一个默认的value.yaml，但是我们可以在命令中覆盖该值，如下:

```
helm install --values=myvals.yaml wordpress
```

## 使用helm管理chart 

* 创建新的chart,如下命令，会帮助我们创建新的chart  
```bash
$ helm create mychart
Created mychart/
```

* 压缩chart成为压缩包 

```bash
nicks-MacBook-Pro:k8s nick$ helm package mychart/
Successfully packaged chart and saved it to: /Users/nick/Desktop/study/k8s/mychart-0.1.0.tgz
```

* 在调试chart的时候，我们可以使用如下命令检查错误；

```bash
nicks-MacBook-Pro:k8s nick$ helm lint mychart
==> Linting mychart
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, no failures
```


JFrog Artifactory