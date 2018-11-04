## volume emptyDir
 
* 资源定义文件``emptyDir.yaml``

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
spec:
  containers:
  - image: redis
    name: redis
    volumeMounts:
    - mountPath: /cache   # 容器的目录
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}
```

* 创建``kubectl create -f emptyDir.yaml``

* 查看挂载情况

```
[root@localhost volume]# kubectl exec -it redis-pod bash 
root@redis-pod:/data# ls /cache/
root@redis-pod:/data# mount | grep cache 
/dev/mapper/centos-root on /cache type xfs (rw,relatime,attr2,inode64,noquota)
```

