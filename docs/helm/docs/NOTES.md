# NOTES.txt

该文件是chart的帮助文件，当执行helm install 和helm upgrade之后会显示该文件。 

* 创建文件templates/NOTES.txt

```
Thank you for installing {{ .Chart.Name }}.

Your release is named {{ .Release.Name }}.

To learn more about the release, try:

  $ helm status {{ .Release.Name }}
  $ helm get {{ .Release.Name }}
```

* 执行安装后，显示如下信息：  

```BASH 
nicks-MacBook-Pro:mychart nick$ helm install ./
NAME:   sanguine-aardvark
LAST DEPLOYED: Thu Oct  3 09:29:58 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME               DATA  AGE
mychart-configmap  3     0s


NOTES:
Thank you for installing mychart.

Your release is named sanguine-aardvark.

To learn more about the release, try:

  $ helm status sanguine-aardvark
  $ helm get sanguine-aardvark
```