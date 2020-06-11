# 本地仓库上传包到私有maven仓库


## 手动mvn命令上传单个Jar 


```bash
# 需要修改如下参数   
host_ip=192.168.1.11:8801
local_file=./ojdbc6.jar 
groupId=com.oracle
artifactId=ojdbc6
version=1.2.0
# 上传包   
mvn deploy:deploy-file \
  -DgroupId=${groupId} \
  -DartifactId=${artifactId} \
  -Dversion=${version} \
  -Dpackaging=jar \
  -Dfile=${local_file} \
  -Durl=http://${host_ip}/repository/maven-releases/ \
  -DrepositoryId=nexus
```

## 批量上传maven仓库所有jar包

1. 本地maven/repository仓库打一个完整的zip压缩包
1. 上传到linux用户目录
1. 上传jar包  

```bash 
cd ~
# 解压文件
unzip repository.zip
cd repository

# 准备文件  
cat  <<'EOF'> mavenimport.sh
#!/bin/bash
# copy and run this script to the root of the repository directory containing files
# this script attempts to exclude uploading itself explicitly so the script name is important
# Get command line params

while getopts ":r:u:p:" opt; do
	case $opt in
		r) REPO_URL="$OPTARG"
		;;
		u) USERNAME="$OPTARG"
		;;
		p) PASSWORD="$OPTARG"
		;;
	esac
done

find . -type f \
   -not -path './mavenimport\.sh*' \
    -not -path '*/\.*' \
    -not -path '*/\^archetype\-catalog\.xml*' \
    -not -path '*/\^maven\-metadata\-local*\.xml' \
    -not -path '*/\^maven\-metadata\-deployment*\.xml' \
    | sed "s|^\./||" \
    | xargs -I '{}' curl -u "$USERNAME:$PASSWORD" -X PUT -v -T {} ${REPO_URL}/{} ;
EOF





chmod +x mavenimport.sh


# 添加执行权限,下面的参数需要修改    
host_ip=192.168.1.11:8801
user_name=admin
user_password=admin123
# 推送jar包   
./mavenimport.sh -u ${user_name} -p ${user_password} -r http://${host_ip}/repository/maven-releases/

```


