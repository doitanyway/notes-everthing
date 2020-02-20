# 打包django程序


## 前言

通常我们希望我们的程序可以被其他程序引用，所以我们把我们的程序打包，供其他软件复用。 


## 打包文件准备


* 创建一个文件夹``django-polls``,把原来的``polls``工程拷贝过去 

* 创建项目描述文件``django-polls/README.rst``


```md
Polls
=====

Polls is a Django app to conduct Web-based polls. For each question,
visitors can choose between a fixed number of answers.

Detailed documentation is in the "docs" directory.

Quick start
-----------

1. Add "polls" to your INSTALLED_APPS setting like this::

    INSTALLED_APPS = [
        ...
        'polls',
    ]

2. Include the polls URLconf in your project urls.py like this::

    path('polls/', include('polls.urls')),

3. Run `python manage.py migrate` to create the polls models.

4. Start the development server and visit http://127.0.0.1:8000/admin/
   to create a poll (you'll need the Admin app enabled).

5. Visit http://127.0.0.1:8000/polls/ to participate in the poll.
```

* 根据自己的情况创建``django-polls/LICENSE``文件(可选)

* 创建docs夹，并且添加一些说明文件

* 创建``django-polls/setup.cfg``文件  
```cfg
[metadata]
name = django-polls
version = 0.1
description = A Django app to conduct Web-based polls.
long_description = file: README.rst
url = https://www.example.com/
author = Your Name
author_email = yourname@example.com
license = BSD-3-Clause  # Example license
classifiers =
    Environment :: Web Environment
    Framework :: Django
    Framework :: Django :: X.Y  # Replace "X.Y" as appropriate
    Intended Audience :: Developers
    License :: OSI Approved :: BSD License
    Operating System :: OS Independent
    Programming Language :: Python
    Programming Language :: Python :: 3
    Programming Language :: Python :: 3 :: Only
    Programming Language :: Python :: 3.6
    Programming Language :: Python :: 3.7
    Programming Language :: Python :: 3.8
    Topic :: Internet :: WWW/HTTP
    Topic :: Internet :: WWW/HTTP :: Dynamic Content

[options]
include_package_data = true
packages = find:
```

* ``django-polls/setup.py``

```py 
from setuptools import setup

setup()
```

* 默认情况下打包程序只包含python模组和包，为了包含其他文件，我们将会创建一个文件``django-polls/MANIFEST.in``

```in
include LICENSE
include README.rst
recursive-include polls/static *
recursive-include polls/templates *
recursive-include docs *
```

## 编译打包程序   

```bash 
# 将会生成打包文件dist/django-polls-0.1.tar.gz
python setup.py sdist
```


## 测试使用包  

```bash
# 换个目录，创建一个新的工程
cd ../
django-admin startproject mysite1
# 安装该包
python3 -m pip install --user django-polls/dist/django-polls-0.1.tar.gz

```

* 修改文件 ``mysite1/settings.py``,中的INSTALLED_APPS，添加``polls``

```
  INSTALLED_APPS = [
        ...
        'polls',
    ]
```

* 修改``mysite1/urls.py``， 配置URL  

```py
urlpatterns = [
    path('admin/', admin.site.urls),
    path('polls/', include('polls.urls')),
]

```

* 执行命令 `python3 manage.py migrate` 初始化数据库.


*  创建一个管理员账号  

```bash 
$ python3 manage.py createsuperuser
# 键入你想要使用的用户名，然后按下回车键：
Username: admin
# 然后提示你输入想要使用的邮件地址：
Email address: qiujiahongde@163.com
# 最后一步是输入密码。你会被要求输入两次密码，第二次的目的是为了确认第一次输入的确实是你想要的密码。
Password: **********
Password (again): *********
Superuser created successfully.
```

* 启动服务器 

```bash 
python3 manage.py runserver
```


