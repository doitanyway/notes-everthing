
```yaml

  - containerID: docker://05aefa86199cea682dc8554cfbe3bda53a10aa2639a9e1aff74f186e996fb4c1
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:b73f527d86e3461fd652f62cf47e7b375196063bbbd503e853af5be16597cb2e
    lastState: {}
    name: glusterfs
    ready: true
    restartCount: 0
    state:
      running:
        startedAt: 2018-11-04T10:12:48Z
  hostIP: 192.168.3.91
  phase: Running
  podIP: 172.20.0.14
  qosClass: BestEffort
  startTime: 2018-11-04T10:12:33Z
[root@k8s glusterfs]# clear

[root@k8s glusterfs]# kubectl get pod glusterfs -oyaml 
apiVersion: v1
kind: Pod
metadata:
  name: glusterfs
spec:
  containers:
  - name: glusterfs
    image: nginx
    volumeMounts:
    - mountPath: "/mnt/glusterfs"
      name: glusterfsvol
      readOnly: true
  volumes:
  - glusterfs:
      endpoints: glusterfs-cluster
      path: models
      readOnly: true
    name: glusterfsvol
```