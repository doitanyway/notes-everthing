# helm命令



      
## helm install
* 作用： 安装charts
* 格式： helm install [CHART] [flags]
* 例：
  * helm install stable/mysqlha
  * 使用文件传入参数：

```BASH
cat << EOF > config.yaml
mariadbUser: user0
mariadbDatabase: user0db
EOF
helm install -f config.yaml stable/mariadb
```


## helm search 

* 作用： 查询系统内配置的所有仓库的匹配的charts
* 格式： helm search [keyword] [flags]
* 例： 
  * helm search 
  * helm search mysql     # 搜索有mysql 关键字的chart

## helm repo 
* 作用： 管理系统配置的仓库
* 格式: helm repo [command]
* 例： 
  * helm repo list
  * 
  
## helm inspect 
* 作用： 查询和打印 Chart.yaml和values.yaml的值

* 例： 
  * helm inspect stable/mysqlha



## helm upgrade

## helm rollback

## helm get   

## helm delete

## helm list

## helm create deis-workflow

## helm package deis-workflow

##  helm install ./deis-workflow-0.1.0.tgz

## helm delete
