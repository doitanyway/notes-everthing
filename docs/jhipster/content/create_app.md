#  创建应用

## 创建

```bash 
# 创建目录
mkdir myapplication
# 进入目录，执行jhipster命令
cd myapplication
jhipster

# 按提问初始化
? Which *type* of application would you like to create? Monolithic application (recommended for simple projects)
? What is the base name of your application? myapplication
? What is your default Java package name? org.jhipster.blog
? Do you want to use the JHipster Registry to configure, monitor and scale your application? No
? Which *type* of authentication would you like to use? JWT authentication (stateless, with a token)
? Which *type* of database would you like to use? SQL (H2, MySQL, MariaDB, PostgreSQL, Oracle, MSSQL)
? Which *production* database would you like to use? MySQL
? Which *development* database would you like to use? H2 with disk-based persistence
? Do you want to use the Spring cache abstraction? Yes, with the Ehcache implementation (local cache, for a single node)
? Do you want to use Hibernate 2nd level cache? Yes
? Would you like to use Maven or Gradle for building the backend? Maven
? Which other technologies would you like to use? (Press <space> to select, <a> to toggle all, <i> to invert selection)
? Which *Framework* would you like to use for the client? Angular
? Would you like to use a Bootswatch theme (https://bootswatch.com/)? Default JHipster
? Would you like to enable internationalization support? Yes
? Please choose the native language of the application English
? Please choose additional languages to install (Press <space> to select, <a> to toggle all, <i> to invert selection)
? Besides JUnit and Jest, which testing frameworks would you like to use? Gatling
? Would you like to install other generators from the JHipster Marketplace? Yes
? Which other modules would you like to use? (Press <space> to select, <a> to toggle all, <i> to invert selection)


## 项目创建成功打印如下日志 
Application successfully committed to Git.

If you find JHipster useful consider sponsoring the project https://www.jhipster.tech/sponsors/

Server application generated successfully.

Run your Spring Boot application:
./mvnw

Client application generated successfully.

Start your Webpack development server with:
 npm start
```



## 启动应用

```bash 
# 执行命令启动项目
./mvnw
```


* 访问地址http://localhost:8080/可以访问创建好的 jhipster程序

