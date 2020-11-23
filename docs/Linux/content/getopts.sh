#!/bin/bash 

while getopts 'a:bcd:' OPT; do
    case ${OPT} in
      a)
        echo "选项-a已经生效"
        echo "选项-a是可以带参数的,参数值为:"${OPTARG}
        ;;
      b)
        echo "选项-b已经生效"
        echo "选项-b是不需要参数的"
        ;;
      c)
        echo "选项-c已经生效"
        echo "选项-c是不需要参数的"
        ;;
      d)
        echo "选项-d已经生效"
        echo "选项-d是可以带参数的,参数值为:"${OPTARG}
        ;;
      *)
        echo "无效的参数"
        ;;
    esac
done