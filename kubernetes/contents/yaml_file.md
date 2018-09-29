## ymal配置文件管理

### 准备知识
*  获取api版本
```
kubectl api-versions
```


### 创建nginx deployment

* 创建deployment对象定义文件，nginx-deployment.yaml
```yaml
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
  labels :
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

* 创建deployment ``kubectl create -f nginx-deployment.yaml``

* 创建后检查
```
kubectl get all -o wide 
```

### 创建nginx service 

* 创建service 对象定义文件,nginx-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx
spec:
  ports:
  - port: 88
    targetPort: 80
  selector:
    app: nginx     # 选择器需要和deployment对应上
```

* 创建service ``kubectl create -f nginx-service.yaml``

* 创建后检查

```bash
[root@node1 nginx]# kubectl get svc 
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.68.0.1       <none>        443/TCP   13d
nginx-service   ClusterIP   10.68.134.163   <none>        88/TCP    2m
[root@node1 nginx]# kubectl describe svc nginx-service
Name:              nginx-service
Namespace:         default
Labels:            app=nginx
Annotations:       <none>
Selector:          app=nginx
Type:              ClusterIP
IP:                10.68.134.163
Port:              <unset>  88/TCP
TargetPort:        80/TCP
Endpoints:         172.20.1.11:80,172.20.1.12:80,172.20.2.13:80
Session Affinity:  None
Events:            <none>
```

* 集群内任意节点上访问nginx 
```bash
[root@node1 nginx]# curl -I 10.68.134.163:88    ## 该ip地址是kubectl describe svc nginx-service命令返回的ip
HTTP/1.1 200 OK
Server: nginx/1.10.3
Date: Sat, 29 Sep 2018 16:02:47 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 31 Jan 2017 15:01:11 GMT
Connection: keep-alive
ETag: "5890a6b7-264"
Accept-Ranges: bytes
```


### 其他检查

* 查看pod日志

```bash
[root@node1 nginx]# kubectl get pod 
NAME                                READY     STATUS    RESTARTS   AGE
nginx-deployment-6c545877dc-49mh2   1/1       Running   0          18m
nginx-deployment-6c545877dc-gdntm   1/1       Running   0          18m
nginx-deployment-6c545877dc-qphhl   1/1       Running   0          18m
[root@node1 nginx]# kubectl logs nginx-deployment-6c545877dc-qphhl
192.168.3.92 - - [29/Sep/2018:16:05:52 +0000] "HEAD / HTTP/1.1" 200 0 "-" "curl/7.29.0" "-"
```