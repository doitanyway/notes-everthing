# 安装与卸载


##  安装 

* 在[python官网](https://www.python.org/downloads/)下载安装python

* mac配置国内镜像

```bash 
# 创建目录  
mkdir ~/.pip 
# 创建文件   
cat << EOF >> ~/.pip/pip.conf
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host = mirrors.aliyun.com
EOF
```

* windows配置国内镜像,打开用户目录 %Users/${username}/% , 如(C:/Users/用户名/), 在此目录下创建 pip 文件夹,在 pip 目录下创建 pip.ini 文件, 内容如下

```BASH 
[global]
timeout = 6000
index-url = http://mirrors.aliyun.com/pypi/simple/
trusted-host = mirrors.aliyun.com
```

* 安装国django 

```bash 
# pip3 install Django
# 指定版本
pip3 install Django==3.0.2

# 验证安装
python3 -m django --version

nick@nicks-MacBook-Pro  ~/Desktop/study  python3
Python 3.7.4 (default, Jul  9 2019, 18:13:23)
[Clang 10.0.1 (clang-1001.0.46.4)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import django
>>> print(django.get_version())
3.0.2

```



## 卸载 

```BASH 
pip3 uninstall Django
```