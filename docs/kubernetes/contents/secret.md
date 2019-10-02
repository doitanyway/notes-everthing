# secret


## 为镜像仓库创建一个secret


* 创建secret 

```bash
# 格式
kubectl create secret docker-registry <name> --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL

# eg
kubectl create secret docker-registry myregistrykey --docker-server=nick.com --docker-username=nick --docker-password=123 --docker-email=nick@12.com


# kubectl create secret docker-registry crcloud --docker-server=registry.steam.crcloud.com \
#      --docker-username=crcsoft-fr19 --docker-password=APAKYo3uM4RaHCZXFuKpnYFTqhd  --docker-email=nick@12.com

```

* 设置secret 

```yaml
cat <<EOF > pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: foo
  namespace: awesomeapps
spec:
  containers:
    - name: foo
      image: janedoe/awesomeapp:v1
  imagePullSecrets:
    - name: myregistrykey
EOF
# 1.4之火支持
cat <<EOF >> ./kustomization.yaml
resources:
- pod.yaml
EOF
```
