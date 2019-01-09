## service的管理

service的[官方说明](https://kubernetes.io/docs/concepts/services-networking/service/)

## 入门示例

* cluster.yaml ,声明一个nginx deployment，再绑定一个cluster ip 类型的service。``kubectl apply -f cluster.yaml``

````yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
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
````

* 查看svc``kubectl get svc ``
```bash
[root@iZwz96gegdh4zx2mlgqsfgZ clusterip]#  kubectl get svc -o wide 
NAME                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE    SELECTOR
kubernetes          ClusterIP   10.68.0.1      <none>        443/TCP          11d    <none>
my-service          ClusterIP   10.68.178.17   <none>        80/TCP,433/TCP   5m5s   app=MyApp
```

* 获取负载均衡背后的应用  
```bash
[root@iZwz96gegdh4zx2mlgqsfgZ clusterip]# kubectl get endpoints my-service
NAME         ENDPOINTS                                                  AGE
my-service   172.20.0.10:80,172.20.0.11:80,172.20.0.12:80 + 3 more...   5m49s
```


* 访问服务器 `` curl 172.20.1.19:80``


* 查看pod的标签  
```bash 
[root@iZwz96gegdh4zx2mlgqsfgZ clusterip]# kubectl get pods --show-labels
NAME                                 READY   STATUS    RESTARTS   AGE    LABELS
naginx-deployment-7c85fb66bb-clpzk   1/1     Running   0          6m7s   app=MyApp,pod-template-hash=7c85fb66bb
naginx-deployment-7c85fb66bb-dpdmm   1/1     Running   0          6m7s   app=MyApp,pod-template-hash=7c85fb66bb
naginx-deployment-7c85fb66bb-gmcvz   1/1     Running   0          6m7s   app=MyApp,pod-template-hash=7c85fb66bb
```

* 直接编辑svc 

```
[root@node1 pod]# kubectl edit svc/my-service
```


* 清理资源

```yaml
[root@iZwz96gegdh4zx2mlgqsfgZ clusterip]# kubectl delete -f cluster.yaml 
service "my-service" deleted
deployment.apps "naginx-deployment" deleted
```
