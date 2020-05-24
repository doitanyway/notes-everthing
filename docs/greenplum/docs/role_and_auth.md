# greenplum角色权限管理

## 什么是角色

* Role 的组成包括用户(User)和用户组(Group)
* User通过Master登录认证
* Role的定义是GreenPlum系统级别的
* 初始化的超级角色为：gpadmin

## 角色权限安全最佳实践

* 保护gpadmin系统用户
* 为每个用户分配不同的角色
* 使用Group来管理权限
* 控制具备superuser属性的user数量

## 创建角色用户User Role

## 创建对象权限

