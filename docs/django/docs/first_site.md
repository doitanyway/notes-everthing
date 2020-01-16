# 创建第一个django站点

## 创建工程

```bash 
# 创建project
django-admin startproject mysite

# 启动项目
cd mysite
python3 manage.py migrate
python3 manage.py runserver

# 访问http://127.0.0.1:8000/检查第一个应用是否正常启动。

# 修改端口启动服务
python3 manage.py runserver 8080

# 绑定网卡启动服务，如下0是0.0.0.0的简称
python3 manage.py runserver 0:8000

````

## 创建APP

* 创建一个APP  

```bash
python3 manage.py startapp polls
```

> APP 是一个特定功能的WEB应用
> 工程包含一些配置，以及多个应用APP


* 编写第一个view文件 ``polls/views.py `` 

```py
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
```

* 新建并编写`` polls/urls.py``,该文件是路由控制文件   

```py 
from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```


* 配置polls的root路径 ``mysite/urls.py``  
```py 
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('polls/', include('polls.urls')),
    path('admin/', admin.site.urls),
]
```

* 重新运行服务  

```bash 
# 访问 http://localhost:8000/polls/
python manage.py runserver

```