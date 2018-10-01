## ansible playbook 入门

### 前言

ansible playbook 是什么？
* 是一门自动化运维的编程语言，顺序、条件、循环等操作；
* 使用yaml格式实现；
* 支持编排非常复杂的任务；
* 是对adhoc的编码；

## hello word

在本章节我们会使用playbook 在服务器上输出一条命令。

* host 文件 /etc/ansible/host

```
web1 ansible_ssh_port=22 ansible_ssh_host=192.168.3.90 ansible_ssh_user=root
[webs]
web1
```

* test.yaml

```
---
- hosts: webs
  remote_user: root
  tasks: 
  - name: Hello world 
    shell: ls /root
```

* 执行playbook 

```
fangleMac:ansible fangle$ ansible-playbook test.yaml 

PLAY [webs] ***************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************
ok: [web1]

TASK [Hello world] ********************************************************************************************************************
changed: [web1]

PLAY RECAP ****************************************************************************************************************************
web1                       : ok=2    changed=1    unreachable=0    failed=0  
```



### 用户变量

```
---
- hosts: webs
  remote_user: root
  vars:
      path: /root
  tasks: 
  - name: Hello world 
    shell: ls {{path}}
```

> 如上图所示，程序声明了一个变量path,声明在vars对象下，使用直接用2个花括号包含即可；
> 需要注意的是如果这里变量直接声明为``/root``,那么shell后面的语句需要整个用引号包含起来，不然会报错；``shell: "{{path}}"``

### 系统变量

ansible 给我们提供了很多的系统变量

