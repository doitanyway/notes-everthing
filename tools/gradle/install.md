# 安装GRADLE

## 安装步骤
* 在[官网](https://gradle.org/install/)下载 gradle
* 创建一个文件夹``C:\Gradle``，在该文件夹下解压该文件；
* 设置环境变量``path``添加``C:\Gradle\gradle-x.x\bin``
* 验证是否安装成功；

```
PS E:\notes-everthing> gradle -v

------------------------------------------------------------
Gradle 3.3
------------------------------------------------------------

Build time:   2017-01-03 15:31:04 UTC
Revision:     075893a3d0798c0c1f322899b41ceca82e4e134b

Groovy:       2.4.7
Ant:          Apache Ant(TM) version 1.9.6 compiled on June 29 2015
JVM:          1.8.0_31 (Oracle Corporation 25.31-b07)
OS:           Windows 8.1 6.3 amd64
```

## 使用gradle命令行
### 执行多个任务

``build.gradle``  
```
task compile {
    doLast {
        println 'compiling source'
    }
}

task compileTest(dependsOn: compile) {
    doLast {
        println 'compiling unit tests'
    }
}

task test(dependsOn: [compile, compileTest]) {
    doLast {
        println 'running unit tests'
    }
}

task dist(dependsOn: [compile, test]) {
    doLast {
        println 'building the distribution'
    }
}
```

执行命令``gradle dist test``

```
$ gradle dist test
:compile
compiling source
:compileTest
compiling unit tests
:test
running unit tests
:dist
building the distribution

BUILD SUCCESSFUL

Total time: 1.045 secs
```
如上所有的任务只执行一次，所以``gradle test test``和``gradle test``的命令是一样的。

### 排除一个任务

``gradle dist -x test``
```
$ gradle dist -x test
:compile
compiling source
:dist
building the distribution

BUILD SUCCESSFUL

Total time: 1.041 secs
```
### 出错时继续编译 
--continue 

### 任务名称简写
如我们任务中有一个任务名称为``dist``,且只有该任务为``di``开头，则可以使用``gradle di``执行该命令

```
$ gradle di
:compile
compiling source
:compileTest
compiling unit tests
:test
running unit tests
:dist
building the distribution

BUILD SUCCESSFUL

Total time: 1.034 secs
```

### 选择指定的build文件执行

``gradle -q -b subdir/myproject.gradle hello``

### 获取build工程信息

* 列举Projects 
``gradle -q projects`` 
```
> gradle -q projects

------------------------------------------------------------
Root project
------------------------------------------------------------

Root project 'projectReports'
+--- Project ':api' - The shared API for the application
\--- Project ':webapp' - The Web application implementation

To see a list of the tasks of a project, run gradle <project-path>:tasks
For example, try running gradle :api:tasks
```
* 列举任务
``gradle -q tasks``  

```
$ gradle -q tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Build Setup tasks
-----------------
init - Initializes a new Gradle build. [incubating]
wrapper - Generates Gradle wrapper files. [incubating]

Help tasks
----------
buildEnvironment - Displays all buildscript dependencies declared in root project 'test'.
components - Displays the components produced by root project 'test'. [incubating]
dependencies - Displays all dependencies declared in root project 'test'.
dependencyInsight - Displays the insight into a specific dependency in root project 'test'.
dependentComponents - Displays the dependent components of components in root project 'test'. [incubating]
help - Displays a help message.
model - Displays the configuration model of root project 'test'. [incubating]
projects - Displays the sub-projects of root project 'test'.
properties - Displays the properties of root project 'test'.
tasks - Displays the tasks runnable from root project 'test'.

To see all tasks and more detail, run gradle tasks --all

To see more detail about a task, run gradle help --task <task>
```


## gradle 加速

找到gradle的配置文件路径，例如Windows中的路径为C:\Users\${你的用户名}\.gradle

新建一个文件名为init.gradle，用记事本或者类似的编辑器打开，输入以下内容：
```
allprojects{
  repositories {
    def REPOSITORY_URL = 'http://maven.aliyun.com/nexus/content/groups/public/'
      all { ArtifactRepository repo ->
        if(repo instanceof MavenArtifactRepository){
          def url = repo.url.toString()
          if (url.startsWith('https://repo1.maven.org/maven2') || url.startsWith('https://jcenter.bintray.com/')) {
            project.logger.lifecycle "Repository ${repo.url} replaced by $REPOSITORY_URL."
            remove repo
          }
       }
    }
    maven {
      url REPOSITORY_URL
    }
  }
}
```

[返回](/readme.md)