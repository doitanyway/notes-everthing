## 服务发布NodePort

### 前言

本文是一个发布nginx应用的例子

### 操作步骤

* 准备并发布deployment,``kubectl create -f nginx-deployment.yaml``

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  type: NodePort
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
  - name: https
    protocol: TCP
    port: 433
    targetPort: 443
---
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: naginx-deployment
  namespace: default
  labels:
    web: MyApp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: MyApp
  template:
    metadata:
      labels:
        app: MyApp
    spec:
      containers:
      - name: nginx
        image: nginx:1.10
        ports:
        - containerPort: 80
```


* 查看随机端口,如下21712 是随机端口，80是内部端口,10.68.36.245是集群内ip
```bash
[root@iZwz96gegdh4zx2mlgqsfgZ nodeport]# kubectl get svc 
NAME                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
kubernetes          ClusterIP   10.68.0.1      <none>        443/TCP                      11d
my-service          NodePort    10.68.216.77   <none>        80:21712/TCP,433:23040/TCP   4m31s
```

* 测试访问
  * 集群地址访问 ``curl 10.68.216.77:80``
  * 使用内网地址访问``curl 172.18.80.25:21712``  (192.168.3.91为集群内任意一个主机)


* 清理资源

```yaml
[root@iZwz96gegdh4zx2mlgqsfgZ nodeport]# kubectl delete -f nodeport.yaml 
service "my-service" deleted
deployment.apps "naginx-deployment" deleted
```

