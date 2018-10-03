## service的管理

* 网络代理模式
* 服务代理
* 服务发现
* 发布服务

service的[官方说明](https://kubernetes.io/docs/concepts/services-networking/service/)

## 入门示例

* service.yaml 资源定义文件
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
````

* 创建资源``kubectl get svc ``
* 查看资源   
```bash
[root@node1 pod]# kubectl get svc -o wide
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE       SELECTOR
kubernetes      ClusterIP   10.68.0.1       <none>        443/TCP          17d       <none>
my-service      ClusterIP   10.68.127.11    <none>        80/TCP,433/TCP   33s       app=MyApp
nginx-service   ClusterIP   10.68.134.163   <none>        88/TCP           3d        app=nginx
```

* 获取负载均衡背后的应用  
```bash
[root@node1 pod]# kubectl get endpoints my-service
NAME         ENDPOINTS                        AGE
my-service   172.20.1.19:80,172.20.1.19:443   10m
```


* 访问服务器 `` curl 172.20.1.19:80``


* 查看pod的标签  
```bash 
[root@node1 pod]# kubectl get pods --show-labels
NAME         READY     STATUS    RESTARTS   AGE       LABELS
nginx-pod1   1/1       Running   0          35m       app=nginx
```

* 直接编辑svc 

```
[root@node1 pod]# kubectl edit svc/my-service
```

