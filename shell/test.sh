#!/bin/bash
str="hello world"
# 0-1:从右边n位起 截取n位字符
echo ${str:0-1:1}

if [[ ! -n $str || ${str:0-1:1} == d ]]
then
    echo "Please enter an valid path."
    exit 2
fi
