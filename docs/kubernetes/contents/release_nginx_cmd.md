##  命令发布nginx

* 命令发布deployments
```
kubectl run webserver --image=nginx:alpine 
```

* 查看当前主机的deployments

```
[root@node1 ~]# kubectl get deployments 
NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
webserver   1         1         1            1           2m
[root@node1 ~]# kubectl get pods 
NAME                         READY     STATUS    RESTARTS   AGE
webserver-86dfd744b7-hs4n8   1/1       Running   0          2m
```

* 删除对应的pod，然后再查看pod,我们会看到系统重新启动了一个不同的nginx pod

```
[root@node1 ~]# kubectl delete pod webserver-86dfd744b7-hs4n8 
pod "webserver-86dfd744b7-45vh6" deleted
[root@node1 ~]# kubectl get pods 
NAME                         READY     STATUS    RESTARTS   AGE
webserver-86dfd744b7-c54bk   1/1       Running   0          4s
```


* 发布服务
```
[root@node1 ~]# kubectl expose deployment webserver --type=LoadBalancer --port=80
service/webserver exposed
```

* 获取service 状态,32378 对应开放的主机ip

```
[root@node1 ~]# kubectl get services 
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP      10.68.0.1      <none>        443/TCP        13d
webserver    LoadBalancer   10.68.169.12   <pending>     80:32378/TCP   34s
```

* 获取pod所在的node ip 
```
[root@node1 ~]# kubectl get pod -o wide       
NAME                         READY     STATUS    RESTARTS   AGE       IP            NODE           NOMINATED NODE
webserver-86dfd744b7-c54bk   1/1       Running   0          7m        172.20.2.12   192.168.3.93   <none>
```

* 访问 nginix 
```
curl http://192.168.3.93:32378
```


* 清理删除创建资源

```
[root@node1 ~]# kubectl delete service webserver       
service "webserver" deleted
[root@node1 ~]# kubectl delete deployment webserver 
deployment.extensions "webserver" deleted
```