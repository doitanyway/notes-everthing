CentOS服务器（64位）版本信息为：CentOS release 6.9（Final）
第一步：检测是否符合PPTP的搭建环境的要求：
  1. #modprobe ppp-compress-18 && echo ok 
     这条指令执行之后，显示“ok”则表明通过。
  2. #cat /dev/net/tun
     如果这条指令显示结果为下面的文本，则表示通过：
     cat: /dev/net/tun: File descriptor in bad state（cat: /dev/net/tun: 文件描述符处于错误状态）
第二步：安装ppp和iptables
  