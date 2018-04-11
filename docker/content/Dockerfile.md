# Dockerfile

## 前言
本例讲述了使用dockerfile做一个简单的python网页程序。

## 例子文件

* 四个文件  
```
../flask-app/
├── Dockerfile
├── app.py
├── requirements.txt
└── templates
    └── index.html
```

* Dockerfile  
```dockerfile
# our base image
FROM alpine:3.5

# Install python and pip
RUN apk add --update py2-pip

# install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

# tell the port number the container should expose
EXPOSE 5000

# run the application
CMD ["python", "/usr/src/app/app.py"]
```


* app.py  
```python
from flask import Flask, render_template
import random

app = Flask(__name__)

# list of cat images
images = [
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26388-1381844103-11.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr01/15/9/anigif_enhanced-buzz-31540-1381844535-8.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26390-1381844163-18.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/10/anigif_enhanced-buzz-1376-1381846217-0.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr03/15/9/anigif_enhanced-buzz-3391-1381844336-26.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/10/anigif_enhanced-buzz-29111-1381845968-0.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr03/15/9/anigif_enhanced-buzz-3409-1381844582-13.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr02/15/9/anigif_enhanced-buzz-19667-1381844937-10.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26358-1381845043-13.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/9/anigif_enhanced-buzz-18774-1381844645-6.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr06/15/9/anigif_enhanced-buzz-25158-1381844793-0.gif",
    "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr03/15/10/anigif_enhanced-buzz-11980-1381846269-1.gif"
]

@app.route('/')
def index():
    url = random.choice(images)
    return render_template('index.html', url=url)

if __name__ == "__main__":
    app.run(host="0.0.0.0")
```

* requirements.txt  
```
Flask==0.10.1
```
* index.html
```html
<html>
  <head>
    <style type="text/css">
      body {
        background: black;
        color: white;
      }
      div.container {
        max-width: 500px;
        margin: 100px auto;
        border: 20px solid white;
        padding: 10px;
        text-align: center;
      }
      h4 {
        text-transform: uppercase;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h4>Cat Gif of the day</h4>
      <img src="{{url}}" />
      <p><small>Courtesy: <a href="http://www.buzzfeed.com/copyranter/the-best-cat-gif-post-in-the-history-of-cat-gifs">Buzzfeed</a></small></p>
    </div>
  </body>
</html>
```

## 执行命令

* 编译镜像   
```
$ docker build -t <YOUR_USERNAME>/myfirstapp .
```

* 运行镜像     
```
$ docker run -p 8888:5000 --name myfirstapp YOUR_USERNAME/myfirstapp
```

* 推送镜像到服务器   
```
docker login                            # 使用你的账户登陆dockerhub
docker push YOUR_USERNAME/myfirstapp    # 推送到服务器
```

* 如果后续不再使用可以停止容器，删除镜像   
```
$ docker stop myfirstapp            # 停止容器
$ docker rm myfirstapp              # 删除镜像
```
或者  
```
$ docker rm -f myfirstapp           # 强制删除镜像
```

## Dockerfile讲解

下面是一些关于dockerfile的基础使用的一些总结：

* FROM 位于Dockerfile的开始位置，Dockerfile都必须从FROM命令开始.镜像是按层建立的意味着我们可以在一个镜像的基础上建立另外一个镜像.FROM就帮我们定义了一个基础景象，参数是基础镜像的名字，此外我们可以添加Docker cloud用户名，以及维护者以及镜像版本;格式为``username/imagename:version``.

* RUN 是用赖建设我们创造的镜像，对于每个RUN命令，Docker将会执行命令，然后创建一个新的层的镜像，这种机制下我们可以很容易的回滚镜像的状态，RUN的格式是RUN命令加上一个完整格式的shell命令(e.g., RUN mkdir /user/local/foo). 这将会自动在/bin/sh shell中执行，我们可以定义一个不同的Shell，方法如: RUN /bin/bash -c 'mkdir /user/local/foo'

* COPY 复制本地文件到容器中去；

* CMD 该命令定义了将会在容容器启动后执行的一些命令，和RUN不同的是这条命令不会创建一个新的层，而只会简单的执行命令，每个Dockerfile/image只能又一个cmd命令，如果你想执行多个命令，最好的方法是使用cmd运行一个搅拌，CMD需要我们告诉他在哪里执行这个命令，和RUN不同，CMD例子如下：
```
  CMD ["python", "./app.py"]

  CMD ["/bin/bash", "echo", "Hello World"]
```

* EXPOSE 暴露一个端口对外提供服务器，它的信息可以通过``$ docker inspect <container-id>``命令获取.

* PUSH 推送镜像到云上去，也可以推送到我们的私有云上去；

如果希望了解更多的dockerfile的编写知识，可以看[Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
