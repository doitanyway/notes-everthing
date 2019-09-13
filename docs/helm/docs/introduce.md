# helm介绍

Helm帮助我们管理kubernetes应用  - Helm charts帮助我们定义、安装和升级kubernetes应用。

使用chart使得创建、版本控制、发布分享应用都更加容易。

Helm现在由CNCF维护，在社区内有Microsoft, Google, Bitnami 以及众多社区贡献者贡献。


## helm的目标

Helm是一个来管理Kubernetes包（又叫charts）的工具，有了heml可以做如下工作：


* 从0开始创建charts
* 打包charts到压缩文件中 (tgz) 
* 和chart repositories通讯
* 在已有的kuberntes集群中安装和卸载charts
* 管理charts的发布周期

对于helm来说有三个重要的概念：

* chart包含了一系列的创建kubernetes 应用所需要的信息；
* 配置包含可以被合并到chart中创建对象的信息；
* 一个发布是chart的运行的实例，合并了一些具体的配置。

## helm的架构

helm包含两个主要的组件
* helm客户端，是为用户提供的一个客户端工具主要负责
  * chart逻辑开发；
  * 管理仓库
  * 和tiller通讯，包括：发送待安装的chart，查询发布信息，请求更新和删除已经存在的发布版本；

* tiller 服务器，与helm 客户端交互，作为kubernetes api server的接口，负责：
  * 监听helm client的请求；
  * 合并chart和配置，发布一个版本；
  * 安装charts到kubernetes，然后跟踪版本；
  * 更新和删除charts；
  

## 实现
helm使用go语言实现，使用gRPC协议与tiller server通讯；

Tiller server也使用go语言实现，提供了gRPC server去连接客户端，使用Kubernetes clinet liberary和kubernetes通讯，当前这个Library使用REST+JSON实现.

Tiller server当前存储数据到kubernetes的configmap中去，不需要单独的数据库。
