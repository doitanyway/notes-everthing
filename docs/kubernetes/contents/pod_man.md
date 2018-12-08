## pod的管理

* 创建/查询/更新/删除

* 资源限制

* 调度约束

* 重启策略

* 健康检查  

* 问题定位



## 创建/查询/更新/删除

* 准备资源定义文件``pod.yaml``

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels: 
    app: nginx
spec:
  containers:
  - name: nginx 
    image: nginx
```

* 创建pod ``kubectl create -f pod.yaml ``


* 查看pod状态(default命名空间下)

```
[root@node1 pod]# kubectl get pods 
NAME        READY     STATUS              RESTARTS   AGE
nginx-pod   0/1       ContainerCreating   0          5s
```

或者

```
[root@node1 pod]# kubectl get pods -o  wide 
NAME        READY     STATUS    RESTARTS   AGE       IP            NODE           NOMINATED NODE
nginx-pod   1/1       Running   0          11m       172.20.2.18   192.168.3.93   <none>
```

* 查看指定命名空间的pod ``kubectl get pods -n kube-system``


* 查看pod具体的信息

```
kubectl describe pod  nginx-pod
```


* 删除pod

```
kubectl delete -f pod.yaml
```

* 更新pod，更新pod可以先删除pod再修改yaml文件，然后再重新创建pod,也可以使用replace命令

```
kubectl replace -f pod.yaml --force
```

```
kubectl apply -f pod.yaml
```


## 资源的限制


```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels: 
    app: nginx
spec:
  containers:
  - name: nginx 
    image: nginx:1.12
    resources:
      requests: 
        memory: "64Mi"
        cpu: "250m"          # 权重
      limits:
        memory: "128Mi"
        cpu: "500m"
```

> 如上所示，资源限制通过resources下的requests和limits实现，其中requests表示初始申请资源，limits表示最大资源限制。
> Mi表示（1Mi=1024x1024）,M表示（1M=1000x1000）（其它单位类推， 如Ki/K Gi/G）
> cpu: "500m",相对权重值


### 调度的约束

* 可通过Pod.spec.nodeName强制把pod分配到某个节点上；

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels: 
    app: nginx
spec:
  nodeName: 192.168.3.92
  containers:
  - name: nginx 
    image: nginx:1.12
```

> 查看结果``kubectl get pods -o wide``



* 可通过Pod.spec.nodeSelector，通过label-selector机制选择节点
  * 给其中一个node打上标签``kubectl label nodes 192.168.3.93 env_role=dev``
  * 检查标签是否打好``kubectl label nodes 192.168.3.93 env_role=dev``
  * 准备资源管理文件

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod1
  labels: 
    app: nginx
spec:
  #nodeName: 192.168.3.92
  nodeSelector:
    env_role: dev
  containers:
  - name: nginx 
    image: nginx:1.12
```


### pod重启策略

* 设置Pod.spec.restartPolicy可以控制重启策略，可配置的重启策略如下：
  * Always: 容器停止总是重启，默认策略
  * OnFailure: 当容器异常退出才重启
  * Never: 容器终止从不重启

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod1
  labels: 
    app: nginx
spec:
  containers:
  - name: nginx 
    image: nginx:1.12
  restartPolicy: OnFailure
```

### pod的健康检查

kubernates提供probe机制，有以下2种类型

* livenessProbe,如果检查失败将会重启容器，根据pod的restartPolicy来操作；
* readinessProbe,kubernetes会把pod从service endpoints中删除

Probe支持以下三种检查方法

* httpGet,发送http请求，返回200~400则为成功
* exec,执行shell命令状态码为0则成功；
* tcpSocket,发起tcp socket建立成功


* 例

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels: 
    app: nginx
spec:
  containers:
  - name: nginx 
    image: nginx:1.12
    ports:
    - containerPort: 80
    livenessProbe:
      httpGet: 
        path: /index.html
        port: 80
```
  * 创建应用``kubectl create -f pod.yaml ``
  * 检查应用``kubectl describe pod nginx-pod``,在其中Liveness中可以看到探针
  * 查看日志 ``kubectl logs -f nginx-pod``，可以看到每10s有一个请求；
  * 进入容器``kubectl exec -it nginx-pod bash ``，删除/usr/share/nginx/html/index.html，会发现容器会自动删除重建。


### 问题定位


```yaml
kubectl describe TYPE NAME_PREFIX   # 查看实践
kubectl logs POD_NAME               # 查看pod的日志
kubectl exec -it POD_NAME bash      # 进入pod容器
```