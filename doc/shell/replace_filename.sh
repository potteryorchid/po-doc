#!/bin/bash
#替换文件名称，需要改动mv命令最后面需要替换的新&旧字符串
read -t 120 -p ">>>>>>> Please enter an absolute path to the directory where the loop resides and at the end of without '/' : " dir
cd $dir
for loop in `ls -1 | tr ' ' '#'`
do
    # mv "`echo $loop`" "`echo $loop | sed -e 's/旧字符串/新字符串/g'`";
    mv "`echo $loop`" "`echo $loop | sed -e 's/-//g'`";
done
