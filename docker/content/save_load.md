## 镜像的导入和导出


```bash
# 拉取镜像
docker pull gcr.io/google_samples/gb-redisslave:v1

# 保存镜像
docker save -o gb-redisslave.tar gcr.io/google_samples/gb-redisslave:v1

# 导入镜像
docker load -i gb-redisslave.tar 
```

> 应用： 因为网络原因，如上的google镜像我们无法访问，于是可以先在一台有科学上网的电脑上拉去并导出镜像，然后再在需要的主机上拉取对应镜像；