#!/bin/bash
read -t 120 -p ">>>>>>> Please enter an absolute path to the directory where the loop resides and at the end of without '/' : " dir
cd $dir
for loop in `ls -1 | tr ' ' '#'`
do
    mv "`echo $loop`" "`echo $loop | sed -e 's/冒死上传！花15800买来的Netty全套课程 ，127集深入浅出//g'`"
done
