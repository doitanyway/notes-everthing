# helm依赖管理

## 前言

helm chart通常存储chart的依赖在charts文件夹下，也可以通过在根目录下创建一个文件（requirements.yaml）管理依赖，该文件格式如下：

```YAML
# requirements.yaml
dependencies:
- name: nginx
  version: "1.2.3"
  repository: "https://example.com/charts"
- name: memcached
  version: "3.2.1"
  repository: "https://another.example.com/charts"
# 2.2.0 之后开始支持如下格式
dependencies:
- name: nginx
  version: "1.2.3"
  repository: "file://../dependency-chart/nginx"
```