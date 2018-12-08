## volume 2.hostPath


* 资源定义文件 ``hostPath.yaml``

```yaml
apiVersion: v1
kind: Pod 
metadata: 
  name: nginx-pod
spec:
  containers:
  - image: nginx
    name: nginx
    volumeMounts:    # 容器路径
    - mountPath: /test-pd
      name: test-volume
  volumes:
  - name: test-volume
    hostPath: 
      path: /tmp  #主机的路径
      type: Directory 
```

* 创建、查看镜像内的/test-pd目录

```bash
[root@localhost volume]# kubectl create -f hostPath.yaml 
pod/nginx-pod created
[root@localhost volume]# kubectl get pod 
NAME                                 READY     STATUS              RESTARTS   AGE
naginx-deployment-6c545877dc-8s9nh   1/1       Running             1          8d
naginx-deployment-6c545877dc-ckrzx   1/1       Running             1          8d
naginx-deployment-6c545877dc-wtdbb   1/1       Running             1          8d
nginx-6f858d4d45-frn56               1/1       Running             1          8d
nginx-pod                            0/1       ContainerCreating   0          7s
[root@localhost volume]# kubectl exec -it nginx-pod bash 
root@nginx-pod:/# ls /test-pd/
[root@localhost volume]# kubectl describe pod nginx-pod 
```
