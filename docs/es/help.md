# es

* [mac安装es](./content/install_mac.md)
* [mac安装kibana](./content/install_mac_kinba.md)
* [linux安装es](./content/install_linux.md)
* [docker安装es](./content/install_docker.md)
* [安装高可用es](./content/install_ha.md)
* [es的核心概念](./content/es_core.md)
* [es基本操作](./content/es_basic.md)
* [es的mapping](./content/mapping.md)
* [文档的基本操作](./content/document.md)
* [搜索命令](./content/search_cmd.md)
* [分词器](./content/analyzer.md)
* [es支持的类型](./content/type.md)





```bash 
# 自动配置密码
# ./bin/elasticsearch-setup-passwords auto


nick@nicks-MacBook-Pro  ~/Desktop/software/es/elasticsearch-7.13.1/bin  ./bin/elasticsearch-setup-passwords interactive
warning: usage of JAVA_HOME is deprecated, use ES_JAVA_HOME
Initiating the setup of passwords for reserved users elastic,apm_system,kibana,kibana_system,logstash_system,beats_system,remote_monitoring_user.
You will be prompted to enter passwords as the process progresses.
Please confirm that you would like to continue [y/N]y


Enter password for [elastic]:
Reenter password for [elastic]:
Enter password for [apm_system]:
Reenter password for [apm_system]:
Enter password for [kibana_system]:
Reenter password for [kibana_system]:
Enter password for [logstash_system]:
Reenter password for [logstash_system]:
Enter password for [beats_system]:
Reenter password for [beats_system]:
Enter password for [remote_monitoring_user]:
Reenter password for [remote_monitoring_user]:
Changed password for user [apm_system]
Changed password for user [kibana_system]
Changed password for user [kibana]
Changed password for user [logstash_system]
Changed password for user [beats_system]
Changed password for user [remote_monitoring_user]
Changed password for user [elastic]
```