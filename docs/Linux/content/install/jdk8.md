# 安装jdk8

本文介绍如何

```bash
curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O \
 'http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz'
```


```bash

#!/bin/bash

java_home_var=/app/java/

profile_path=/etc/profile
#profile_path=profile2


# 获得参数传入,输入到 变量 java_home_var start 
if test -z "$1"
then
  echo ""
else
  echo input : $1
  java_home_var=$1
fi
# 获得参数传入 end



function handle_null(){
  path_var="";
  echo JAVA_HOME null;
  path_var=$(cat $profile_path | grep 'export PATH=' | awk -F'=' '{print $2}')
  echo path: $path_var
  if test -z "$path_var"
  then
     echo no JAVA_HOME no PATH
     echo "export JAVA_HOME=$java_home_var" >> $profile_path
     echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> $profile_path
  else
     echo no JAVA_HOME have PATH
     path_var=$(cat $profile_path | grep 'export PATH=' | awk -F'=' '{print $2}')
     echo $path_var
     echo "export JAVA_HOME=$java_home_var" >> $profile_path
     sed -i '/^export PATH=/d' $profile_path
     echo "export PATH=\$JAVA_HOME/bin:$path_var" >> $profile_path
  fi
  source $profile_path
  return ;
}


if test -z "$JAVA_HOME1"
then
  handle_null
else
  echo have JAVA_HOME;
fi

echo done...
```


cat profile | grep 'export PATH=' | awk -F'=' '{print $2}'