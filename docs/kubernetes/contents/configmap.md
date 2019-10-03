# configmap

configmap通常使我们的pod可配置，可以注入环境变量，配置文件。本文将举例说明如何使用configmap


## 创建configmap

我们可以使用``kubectl create configmap``或者使用yaml文件中来创建

### 使用kubect create configmap命令创建


通过``kubectl create configmap``可以从文件夹，文件或者一系列的值直接创建

```BASH
kubectl create configmap  <map-name> <data-source>
```

> \<map-name> 是分配给configmap的名字
> \<data-source>可以是文件夹、文件、或者一系列的值
> 创建好了configmap之后，我们可以使用kubectl describe或者kubectl get获取configmap的信息

#### 使用文件夹创建configmap

```BASH
# Create the local directory
mkdir -p configure-pod-container/configmap/

# Download the sample files into `configure-pod-container/configmap/` directory
wget https://kubernetes.io/examples/configmap/game.properties -O configure-pod-container/configmap/game.properties
wget https://kubernetes.io/examples/configmap/ui.properties -O configure-pod-container/configmap/ui.properties

# Create the configmap
kubectl create configmap game-config --from-file=configure-pod-container/configmap/

# 查看这个configmap
kubectl describe configmaps game-config
# 使用yaml 文件的格式查看configmap
kubectl get configmaps game-config -o yaml
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-config
  namespace: default
data:
  game.properties: |-
    enemies=aliens
    lives=3
    enemies.cheat=true
    enemies.cheat.level=noGoodRotten
    secret.code.passphrase=UUDDLRLRBABAS
    secret.code.allowed=true
    secret.code.lives=30
  ui.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true
    how.nice.to.look=fairlyNice
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: special-config
  namespace: default
data:
  special.how: very
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: env-config
  namespace: default
data:
  log_level: INFO
```

#### 使用文件创建configmap


```BASH
# 使用文件创建举例
kubectl create configmap game-config-2 --from-file=configure-pod-container/configmap/game.properties
# 使用多个文件创建
kubectl create configmap game-config-2 --from-file=configure-pod-container/configmap/game.properties --from-file=configure-pod-container/configmap/ui.properties
```

* 使用``--from-env-file``从env-file创建configmap，如下：

```BASH
# Env-files 包含一系列的环境变量。
# 格式规则如下:
#   文件内每行格式 VAR=VAL .
#   以为#开始的行为注释，忽略.
#   空白行忽略.
#   There is no special handling of quotation marks (i.e. they will be part of the ConfigMap value)).

# Download the sample files into `configure-pod-container/configmap/` directory
wget https://kubernetes.io/examples/configmap/game-env-file.properties -O configure-pod-container/configmap/game-env-file.properties

# The env-file `game-env-file.properties` looks like below
cat configure-pod-container/configmap/game-env-file.properties
enemies=aliens
lives=3
allowed="true"

# 利用环境变量文件创建configmap
kubectl create configmap game-config-env-file \
       --from-env-file=configure-pod-container/configmap/game-env-file.properties
kubectl get configmap game-config-env-file -o yaml

# 使用多个env文件创建 configmap
kubectl create configmap config-multi-env-files \
        --from-env-file=configure-pod-container/configmap/game-env-file.properties \
        --from-env-file=configure-pod-container/configmap/ui-env-file.properties
```

> 和--from-file不同的是，使用--from-env-file创建出来的data不会对不同文件做区分，会在同一个列表中。

* 定义一个key name,使用--from-file的时候除了可以使用默认的文件名作为section name，我们也可以指定key作为section name，语法如下；

```BASH
kubectl create configmap game-config-3 --from-file=<my-key-name>=<path-to-file>
kubectl create configmap game-config-3 --from-file=game-special-key=configure-pod-container/configmap/game.properties

```


#### 使用一系列值创建configmap

语法如下： 

```BASH
kubectl create configmap special-config --from-literal=special.how=very --from-literal=special.type=charm

```



### 使用yaml文件创建



* 如下两种格式的yaml文件，可使用``kubectl apply -f file.yaml``创建

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-config
  namespace: default
data:
  game.properties: |-
    enemies=aliens
    lives=3
    enemies.cheat=true
    enemies.cheat.level=noGoodRotten
    secret.code.passphrase=UUDDLRLRBABAS
    secret.code.allowed=true
    secret.code.lives=30
  ui.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true
    how.nice.to.look=fairlyNice
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: special-config
  namespace: default
data:
  special.how: very
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: env-config
  namespace: default
data:
  log_level: INFO
```


### 使用configmap 生成器(1.14版本以上支持)

* configmap生成器文件


```bash
# Create a kustomization.yaml file with ConfigMapGenerator
cat <<EOF >./kustomization.yaml
configMapGenerator:
- name: game-config-4
  files:
  - configure-pod-container/configmap/game.properties
EOF

# 
kubectl apply -k . 
configmap/game-config-4-m9dm2f92bt created
```


## configmap的使用

### configmap定义容器环境变量

* 定义configmap，声明一个变量special.how

```
kubectl create configmap special-config --from-literal=special.how=very
```

* 分配configmap的special.how的值给pod中的SPECIAL_LEVEL_KEY环境变量.

```YAML
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env:
        # Define the environment variable
        - name: SPECIAL_LEVEL_KEY
          valueFrom:
            configMapKeyRef:
              # The ConfigMap containing the value you want to assign to SPECIAL_LEVEL_KEY
              name: special-config
              # Specify the key associated with the value
              key: special.how
  restartPolicy: Never
```

* 创建pod ``kubectl apply -f file.yaml``

### 使用多个configmap定义环境变量


* configmap文件 

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: special-config
  namespace: default
data:
  special.how: very
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: env-config
  namespace: default
data:
  log_level: INFO
```

* pod文件 

```YAML
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env:
        - name: SPECIAL_LEVEL_KEY
          valueFrom:
            configMapKeyRef:
              name: special-config
              key: special.how
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: env-config
              key: log_level
  restartPolicy: Never
```

* 创建pod和configmap

```YAML
kubectl create -f https://kubernetes.io/examples/configmap/configmaps.yaml
kubectl create -f https://kubernetes.io/examples/pods/pod-multiple-configmap-env-variable.yaml
```

### 配置configmap中所有的键值对为环境变量

* configmap ``kubectl create -f configmap-multikeys.yaml``

```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: special-config
  namespace: default
data:
  SPECIAL_LEVEL: very
  SPECIAL_TYPE: charm
```

* pod , ``kubectl create -f pod-configmap-envFrom.yaml``

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      envFrom:
      - configMapRef:
          name: special-config
  restartPolicy: Never
```


### 添加configmap data到指定的路径


```YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: testmap
data:
  test.file: |
    this is a test strings
  test.file2: |
    this is the 2nd strings
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-test
spec:
  containers:
  - name: test
    image: busybox
    tty: true
    command: ["sh"]
    volumeMounts:
    - name: testdir
      mountPath: /root/test.map1
      subPath: test.map1
    - name: testdir
      mountPath: /etc/test.map2
      subPath: test.map2
  volumes:
  - name: testdir
    configMap:
      name: testmap
      items:
      - key: test.file
        path: test.map1
      - key: test.file2
        path: test.map2
```

