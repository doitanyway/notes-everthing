## volume 4.glusterfs


### 准备工作

* 准备一个glusterfs集群,集群信息如下:

```bash
[root@node1 ~]# gluster info 
unrecognized word: info (position 0)
[root@node1 ~]# gluster volume info 
 
Volume Name: models
Type: Replicate
Volume ID: e00e5fa8-fae8-485b-9230-bea79124d4ad
Status: Started
Snapshot Count: 0
Number of Bricks: 1 x 3 = 3
Transport-type: tcp
Bricks:
Brick1: 192.168.3.101:/opt/gluster/data
Brick2: 192.168.3.102:/opt/gluster/data
Brick3: 192.168.3.103:/opt/gluster/data
Options Reconfigured:
transport.address-family: inet
nfs.disable: on
performance.client-io-threads: off
```


* node节点安装客户端软件

```
yum -y install openssh-server wget fuse fuse-libs openib libibverbs
```

### 配置文件

* 创建endpoints, ``kubectl apply -f  glusterfs-endpoints.json``    
```json 
{
  "kind": "Endpoints",
  "apiVersion": "v1",
  "metadata": {
    "name": "glusterfs-cluster"
  },
  "subsets": [
    {
      "addresses": [
        {
          "ip": "192.168.3.101"
        }
      ],
      "ports": [
        {
          "port": 1
        }
      ]
    },
    {
      "addresses": [
        {
          "ip": "192.168.3.102"
        }
      ],
      "ports": [
        {
          "port": 1
        }
      ]
    },
    {
      "addresses": [
        {
          "ip": "192.168.3.103"
        }
      ],
      "ports": [
        {
          "port": 1
        }
      ]
    }
  ]
}
```

* 创建服务  `` kubectl apply -f glusterfs-service.json ``

```json
{
  "kind": "Service",
  "apiVersion": "v1",
  "metadata": {
    "name": "glusterfs-cluster"
  },
  "spec": {
    "ports": [
      {"port": 1}
    ]
  }
}
```

* 创建pod ``kubectl apply -f glusterfs-pod.json ``

```json 
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "name": "glusterfs"
    },
    "spec": {
        "containers": [
            {
                "name": "glusterfs",
                "image": "nginx",
                "volumeMounts": [
                    {
                        "mountPath": "/mnt/glusterfs",
                        "name": "glusterfsvol"
                    }
                ]
            }
        ],
        "volumes": [
            {
                "name": "glusterfsvol",
                "glusterfs": {
                    "endpoints": "glusterfs-cluster",
                    "path": "models",
                    "readOnly": true
                }
            }
        ]
    }
}
```

> 上面spec.volumes[x].glusterfs.path值等于``gluster volume create``创建的卷名，如果不记得卷名，可以使用``gluster volume info``命令获取

> 如果要使用yaml格式，请用如下文件:   
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: glusterfs
spec:
  containers:
  - image: nginx
    name: glusterfs
    volumeMounts:
    - mountPath: /mnt/glusterfs
      name: glusterfsvol
  volumes:
  - glusterfs:
      endpoints: glusterfs-cluster
      path: models
      # readOnly: true
    name: glusterfsvol
```

> 如果要修改volumes，需要先删除，再重建；