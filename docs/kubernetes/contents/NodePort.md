## 服务发布NodePort

### 前言

本文是一个发布nginx应用的例子

### 操作步骤

* 准备并发布deployment,``kubectl create -f nginx-deployment.yaml``

```yaml
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: naginx-deployment
  namespace: default
  labels:
    web: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.10
        ports:
        - containerPort: 80
```

* 准备并发布NodePort服务，``kubectl -f nginx-service.yaml ``

* 查看随机端口,如下24369 是随机端口，80是内部端口,10.68.36.245是集群内ip
```bash
[root@localhost ~]# kubectl get svc | grep nginx-service
nginx-service   NodePort    10.68.36.245    <none>        80:24369/TCP   9m
```

* 测试访问
  * 集群地址访问 ``curl 10.68.36.245:80``
  * 使用内网地址访问``curl 192.168.3.91:24369``  (192.168.3.91为集群内任意一个主机)
