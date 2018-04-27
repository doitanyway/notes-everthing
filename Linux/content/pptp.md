<h1>Linux下PPTP的配置</h1>
CentOS服务器（64位）版本信息为：CentOS release 6.9（Final) 
<h2>第一步：检测是否符合PPTP的搭建环境的要求</h2>
  开始搭建VPN之前的环境检测步骤，执行以下的命令，如果检查结果没有相关支持的话，是不能安装pptp的，执行指令：  
  <code>#modprobe ppp-compress-18 && echo ok</code>  
     这条指令执行之后，显示“ok”则表明通过。  
  <code>#cat /dev/net/tun</code>  
     如果这条指令显示结果为下面的文本，则表示通过：
     cat: /dev/net/tun: File descriptor in bad state（cat: /dev/net/tun: 文件描述符处于错误状态)  
上述两条均通过，才能安装pptp。否则就只能考虑openvpn，或者请vps空间商的技术客服为你的VPS打开TUN/TAP/PPP功能了，貌似有部分vps控制面板上提供打开TUN/TAP/PPP功能的按钮。

<h2>第二步：安装ppp和iptables</h2>
pptpd要求Linux内核支持mppe，一般来说CentOS安装时已经包含了。CentOS默认安装了iptables和ppp，我们要先查看已经安装的ppp的版本，再去找对应的pptpd版本。
     ppp版本查看命令如下:
     <code>#rpm -q ppp</code>//查询当前系统的ppp是否默认集成了，以及ppp的版本  
     ppp和pptpd各个版本下载地址：http://poptop.sourceforge.net/yum/stable/packages/。  
     在这里一定要下载ppp对应的pptpd版本，不然会出错。我所需要下载的版本为pptpd-1.4.0-1.el6.x86_64.rpm，下载及安装命令如下：  
     <code>wget http://poptop.sourceforge.net/yum/stable/packages/pptpd-1.4.0-1.el6.x86_64.rpm</code> // 下载pptpd  
     <code>rpm -ivh pptpd-1.4.0-1.el6.x86_64.rpm</code> //安装pptpd  
     
<h2>第三步：修改配置文件</h2>
1. 配置文件/etc/ppp/options.pptpd，命令如下所示：
<code>#cp /etc/ppp/options.pptpd /etc/ppp/options.pptpd.bak</code>  
     <code>#vi /etc/ppp/options.pptpd</code>  
     将如下内容添加到options.pptpd中：  
     <code>ms-dns 8.8.8.8</code>  
     <code>ms-dns 8.8.4.4</code>  
     然后保存这个文件。（ms-dns 8.8.8.8，ms-dns 8.8.4.4是使用google的dns服务器。）  
2. 配置文件/etc/ppp/chap-secrets，命令如下所示：  
     <code>##cp /etc/ppp/chap-secrets   /etc/ppp/chap-secrets.bak</code>  
     <code>#vi /etc/ppp/chap-secrets</code>  
     按如下格式填写：fangle httpd 123456 *  
     client处是VPN账号，server处是pptpd，secret处是VPN的密码，IP address处填上*（星号表示对任意IP，记住不要丢了这个星号。） 
3. 配置文件/etc/pptpd.conf，命令如下所示：  
    <code>#cp /etc/pptpd.conf     /etc/pptpd.conf.bak</code>  
    <code>#vi /etc/pptpd.conf</code>  
    添加如下两行：  
    <code>localip 192.168.1.1</code>  
    <code>remoteip 192.168.1.10-50</code> //表示vpn客户端获得ip的范围  
4. 配置文件/etc/sysctl.conf，命令如下所示：  
   #vi /etc/sysctl.conf //修改内核设置，使其支持转发  
   将net.ipv4.ip_forward = 0 改成 net.ipv4.ip_forward = 1。  
   保存修改的文件，然后执行如下命令：  
   <code>#/sbin/sysctl -p</code>

<h2>第四步：启动pptp vpn服务和iptables</h2>
   启动pptp vpn的命令如下：
   #/sbin/service pptpd start 或者 #service pptpd start  
   经过前面步骤，我们的VPN已经可以拨号登录了，但是还不能访问任何网页。最后一步就是添加iptables转发规则了。我的规则如下：  
   <code>iptables -t nat -A POSTROUTING -o eth0 -s 192.168.1.1/24 -j SNAT --to-source 211.141.133.8</code>  
   <code>iptables -I INPUT 1 -p gre -j ACCEPT</code>  
   <code>iptables -I INPUT 1 -p tcp -m tcp --dport 1723 -j ACCEPT</code>  
   <code>iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT</code> （一般不执行，防火墙默认设置）  
   <code>iptables -A FORWARD -s 192.168.1.0/24 -o eth0 -j ACCEPT</code>  
   <code>iptables -A FORWARD -d 192.168.1.0/24 -i eth0 -j ACCEPT</code>    
   注意上面规则添加中的eth0这个是网卡，不同的电脑是不相同的，可以使用命令ifconfig查看得到。规则添加完毕之后，先保存一下添加的规则，然后再启动iptables了。命令如下：
   <code>/etc/init.d/iptables save</code>
   <code>service iptables start</code>
   最后，我们可以设置pptpd和iptables随系统自启动。命令如下图所示：  
   <code>chkconfig pptpd on</code>  
   <code>chkconfig iptables on</code>  
   e到此为止，PPTP VPNe服务器的配置完成了。
   
 
<h2>第五步：Win10连接PPTP</h2>
1. 找到“设置”-“网络和Internet”-“VPN”
2. 点击“添加VPN连接”
3. 弹出的对话框中，输入VPN提供商：Window(内置)；连接名称：自定义；服务器名称或地址：填写部署PPTP服务器的地址；VPN类型：点对点隧道协议（PPT）；输入本文中s第三步第2小布设置的用户、密码，点击登陆即可；












  

