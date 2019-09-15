# Helm安装

## 在Mac上安装helm

```bash
# Use homebrew on Mac
brew install kubernetes-helm

# Install Tiller into your Kubernetes cluster
helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 --skip-refresh

# Change helm repo
helm repo add stable http://mirror.azure.cn/kubernetes/charts-incubator/

# Update charts repo (Optional)
helm repo update
```

> brew 安装的版本可能会和 helm server 不兼容, 如果在后续使用 helm 安装组件的过程中出现以下错误，可以 通过二进制包安装 对应的版本

```bash
$ helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
Error: incompatible versions client[v2.13.1] server[v2.12.2]
```

## 通过二进制包安装

```bash
# Download binary release
在 https://github.com/helm/helm/releases 中找到匹配的版本并下载(需要梯子), 如: https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-darwin-amd64.tar.gz

# Unpack

tar -zxvf helm-v2.0.0-linux-amd64.tgz

# Move it to its desired destination

mv darwin-amd64/helm /usr/local/bin/helm
```

## 在Windows上安装

```bash
# Use Chocolatey on Windows
# 注：安装的时候需要保证网络能够访问googleapis这个域名
choco install kubernetes-helm

# Install Tiller into your Kubernetes cluster
helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 --skip-refresh

# Change helm repo
helm repo add stable http://mirror.azure.cn/kubernetes/charts-incubator/

# Update charts repo (Optional)
helm repo update
```
