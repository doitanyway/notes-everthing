# Linux系统下 node安装简介

###  node地址：https://nodejs.org/zh-cn/download/

### 查看Linux系统位数：`uname -a`  

###  下载node，使用官方推荐版，Linux 二进制文件 (x86/x64) 64-bit（根据系统位数下载）

### 安装：
     * 上传服务器可以是自己任意路径，建议/usr/local/下；
     * 解压上传：
         * 新建node文件夹
         * tar -xvf   node-vxx-linux-x64.tar.xz   （node-v8.11.3-linux-x64.tar.xz）
         * mv node-v8.11.3-linux-x64  node （移动文件至node文件）
     * 建立软连接，变为全局：
          *  ln -s /app/software/nodejs/bin/npm /usr/local/bin/ 
          *  ln -s /app/software/nodejs/bin/node /usr/local/bin/
     * 查看安装是否成功：node -v 查看版本（本人版本：v8.11.3）
      