# 建立一个新的gradle build

## 创建一个项目
```
$ mkdir basic-demo
$ cd basic-demo
$ vim build.gradle 
```

## 运行任务命令
* 查看工程的任务
```
$ gradle tasks
```
* 生成gradle wrapper
```
$ gradle wrapper
```
* 执行``properties``任务
```
./gradlew properties
```
## Copy任务

* 工程目录下创建``src``目录
* 在``src``目录下创建``myfile.txt``文件，文件添加内容``Hello, World!``
* 创建一个任务名字是``copy``type是``Copy`` (注意类型是大写)，该任务从src目录拷贝文件到``dest`目录. (不需要创建dest，任务会创建该目录.) 格式如下:
```
task copy(type: Copy) {
    from 'src'
    into 'dest'
}
```
注意：如果编译下载gradle安装文件太慢，则可以自己用迅雷下载文件，然后手动修改``gradle/gradle-wrapper.properties``文件下的``distributionUrl=file:///C:/gradle/gradle-3.3-bin.zip``。
执行 ``./gradlew copy``执行任务。

## 添加打包任务
build.gradle
```
plugins {
    id 'base'
}

task copy(type: Copy) {
    from 'src'
    into 'dest'
}

task zip(type: Zip) {
    from 'src'
}
```
执行任务``./gradlew zip``产生文件``../build/distributions/test.zip``

## 列举所有任务任务

```
PS D:\test> ./gradlew tasks --all
:tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Build tasks
-----------
assemble - Assembles the outputs of this project.
build - Assembles and tests this project.
clean - Deletes the build directory.

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

Verification tasks
------------------
check - Runs all checks.

Other tasks
-----------
copy
zip

Rules
-----
Pattern: clean<TaskName>: Cleans the output files of a task.
Pattern: build<ConfigurationName>: Assembles the artifacts of a configuration.
Pattern: upload<ConfigurationName>: Assembles and uploads the artifacts belonging to a configuration.

BUILD SUCCESSFUL

Total time: 1.186 secs
```

## 清除任务
```
./gradlew clean
```

## 添加一个helloword
build.gradle文件添加
```
task hello {
    doLast {
        println 'Hello, World!'
    }
}
```


## 完整的build.gradle文件
```
plugins {
    id 'base'
}

task copy(type: Copy) {
    from 'src'
    into 'dest'
}

task zip(type: Zip) {
    from 'src'
}

task hello {
    doLast {
        println 'Hello, World!'
    }
}

```



