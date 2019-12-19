# docker常用命令


## 最常用命令

```
## 1.启动docker镜像
docker run hello-world
docker run  -d -p 80:80 -e name='nick' nginx     

-d - 后台运行
-p - 端口映射
-e - 变量
-v - 挂载目录或者文件

## 2.查询docker镜像/容器
docker image ls
docker image ls -a 
docker image ls -qa 
docker ps  
docker ps -a
docker ps -qa 
docker logs -f bd85e5bcffc5        # 查看日志
docker exec -it bd85e5bcffc5 bash  # 命令行进入该容器
docker inspect bd85e5bcffc5

## 3.停止/删除
docker stop bd85e5bcffc5
docker rm bd85e5bcffc5
docker ps -qa | xargs docker stop 
docker rmi bd85e5bcffc5             # 注意这里是删除镜像，删除前对应容器需要先删除

```


## 补充

```bash
## Display Docker version and info
docker --version
docker version
docker info

## 编译docker镜像
docker build -t friendlyhello .  # Create image using this directory's Dockerfile
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry

## 提交一个正在运行的容器一个新镜像
docker commit c16378f943fe username/repository:tag
## 保存镜像到文件
docker save 66bc0f66b7af >/tmp/mysql.tar
docker save REPOSITORY:TAG>/tmp/mysql.tar
## 加载镜像
docker load < /tmp/new-image.tar
docker load --input rocketmq.tar
```