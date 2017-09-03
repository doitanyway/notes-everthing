# 建立一个新的java应用
本文演示了用gradle如何生成一个新的JAVA应用，

## 完成效果
我们将按默认方式生成一个JAVA应用

## 准备条件
* 10分钟
* 文本编辑器，推荐ECLIPSE
* 命令行
* JDK，1.7以上
* gradle

## 准备知识
gradle来源于一个``build init plugin``,它在[gradle用户手册](https://docs.gradle.org/current/userguide/build_init_plugin.html)上有详细介绍。  
该插件有一个任务叫 ``init``可以用来生成项目，``init``任务也叫做``wapper``任务，因为调用该任务可以创建gradle wapper 脚本，gradlew.  

运行该命令格式如下：
```
$ gradle init --type <name>
```
``name``可以是如下类型：
* java-application
* java-library
* scala-library
* groovy-library
* basic
本文使用 ``java-application``

## 创建目录
```
$ mkdir java-demo
$ cd java-demo
```

## 执行init任务
```
$ gradle init --type java-application
Starting a Gradle Daemon (subsequent builds will be faster)
:wrapper
:init

BUILD SUCCESSFUL in 3s
2 actionable tasks: 2 executed
```
执行后，建立以下目录：
```
$ ls -R
.:
build.gradle  gradle/  gradlew*  gradlew.bat  settings.gradle  src/

./gradle:
wrapper/

./gradle/wrapper:
gradle-wrapper.jar  gradle-wrapper.properties

./src:
main/  test/

./src/main:
java/

./src/main/java:
App.java

./src/test:
java/

./src/test/java:
AppTest.java
```


## 执行编译

可以执行编译命令编译项目，可以执行gradle命令，但是当一个项目中包含wrapper脚本的时候，则建议使用``gradlew``代替：

```
$ ./gradlew build
Downloading file:/C:/gradle/gradle-4.1-bin.zip
................................................................
Unzipping C:\Users\Nick\.gradle\wrapper\dists\gradle-4.1-bin\32eufdg5o6cmg7p0zvmkgcj2q\gradle-4.1-bin.             zip to C:\Users\Nick\.gradle\wrapper\dists\gradle-4.1-bin\32eufdg5o6cmg7p0zvmkgcj2q
:compileJava
Download https://jcenter.bintray.com/com/google/guava/guava/22.0/guava-22.0.pom
Download https://jcenter.bintray.com/com/google/guava/guava-parent/22.0/guava-parent-22.0.pom
Download https://jcenter.bintray.com/com/google/code/findbugs/jsr305/1.3.9/jsr305-1.3.9.pom
Download https://jcenter.bintray.com/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.p             om
Download https://jcenter.bintray.com/org/codehaus/mojo/animal-sniffer-annotations/1.14/animal-sniffer-             annotations-1.14.pom
Download https://jcenter.bintray.com/com/google/errorprone/error_prone_annotations/2.0.18/error_prone_             annotations-2.0.18.pom
Download https://jcenter.bintray.com/org/codehaus/mojo/animal-sniffer-parent/1.14/animal-sniffer-paren             t-1.14.pom
Download https://jcenter.bintray.com/com/google/errorprone/error_prone_parent/2.0.18/error_prone_paren             t-2.0.18.pom
Download https://jcenter.bintray.com/org/codehaus/mojo/mojo-parent/34/mojo-parent-34.pom
Download https://jcenter.bintray.com/org/codehaus/codehaus-parent/4/codehaus-parent-4.pom
Download https://jcenter.bintray.com/com/google/code/findbugs/jsr305/1.3.9/jsr305-1.3.9.jar
Download https://jcenter.bintray.com/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.j             ar
Download https://jcenter.bintray.com/com/google/errorprone/error_prone_annotations/2.0.18/error_prone_             annotations-2.0.18.jar
Download https://jcenter.bintray.com/org/codehaus/mojo/animal-sniffer-annotations/1.14/animal-sniffer-             annotations-1.14.jar
Download https://jcenter.bintray.com/com/google/guava/guava/22.0/guava-22.0.jar
:processResources NO-SOURCE
:classes
:jar
:startScripts
:distTar
:distZip
:assemble
:compileTestJava
:processTestResources NO-SOURCE
:testClasses
:test
:check
:build

BUILD SUCCESSFUL in 23s
7 actionable tasks: 7 executed
```

注：
如果下载gradle太慢，则可以网页或者迅雷下载到本地如``file:///C:/gradle/``，修改``vim gradle/wrapper/gradle-wrapper.properties``文件:
``distributionUrl=file:///C:/gradle/gradle-3.3-bin.zip``。

编译完成之后，可以浏览``build/reports/tests/test/index.html``看单元测试报告；

## 执行任务

* 查看当前工程的所有任务
```
$ ./gradlew tasks
:tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Application tasks
-----------------
run - Runs this project as a JVM application

Build tasks
-----------
assemble - Assembles the outputs of this project.
build - Assembles and tests this project.
buildDependents - Assembles and tests this project and all projects that depend on it.
buildNeeded - Assembles and tests this project and all projects it depends on.
classes - Assembles main classes.
clean - Deletes the build directory.
jar - Assembles a jar archive containing the main classes.
testClasses - Assembles test classes.

Build Setup tasks
-----------------
init - Initializes a new Gradle build.
wrapper - Generates Gradle wrapper files.

Distribution tasks
------------------
assembleDist - Assembles the main distributions
distTar - Bundles the project as a distribution.
distZip - Bundles the project as a distribution.
installDist - Installs the project as a distribution as-is.

Documentation tasks
-------------------
javadoc - Generates Javadoc API documentation for the main source code.

Help tasks
----------
buildEnvironment - Displays all buildscript dependencies declared in root project 'java-demo'.
components - Displays the components produced by root project 'java-demo'. [incubating]
dependencies - Displays all dependencies declared in root project 'java-demo'.
dependencyInsight - Displays the insight into a specific dependency in root project 'java-demo'.
dependentComponents - Displays the dependent components of components in root project 'java-demo'. [incubating]
help - Displays a help message.
model - Displays the configuration model of root project 'java-demo'. [incubating]
projects - Displays the sub-projects of root project 'java-demo'.
properties - Displays the properties of root project 'java-demo'.
tasks - Displays the tasks runnable from root project 'java-demo'.

Verification tasks
------------------
check - Runs all checks.
test - Runs the unit tests.

Rules
-----
Pattern: clean<TaskName>: Cleans the output files of a task.
Pattern: build<ConfigurationName>: Assembles the artifacts of a configuration.
Pattern: upload<ConfigurationName>: Assembles and uploads the artifacts belonging to a configuration.

To see all tasks and more detail, run gradlew tasks --all

To see more detail about a task, run gradlew help --task <task>

BUILD SUCCESSFUL in 0s
1 actionable task: 1 executed
```
* 执行main任务
```
$ ./gradlew run
:compileJava UP-TO-DATE
:processResources NO-SOURCE
:classes UP-TO-DATE
:run
Hello world.

BUILD SUCCESSFUL in 0s
2 actionable tasks: 1 executed, 1 up-to-date
```

## 总结
通过本章的学习，学会了一些如何使用gradle build init 插件的方法，如：
* 如何生成JAVA APPLICATION；
* 如何生成build file,以及文件结构是怎么样的；
* 如何执行编译，和查看测试报告；
* 如何执行JAVA 应用程序。
