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