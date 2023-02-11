#!/bin/bash
# 删除第一个“.”及其前面的字符串
read -t 120 -p ">>>>>>> Please enter an absolute path to the directory where the file resides and at the end of without '/': " dir
if [[ ! -n $dir || ${dir:0-1:1} == / ]]
then
    echo "Please enter an valid path."
    exit 2
fi

cd $dir
for file in $(ls $dir)
do
    #mv $dir/$file $dir/${file#*参数字符}
    mv $dir/$file $dir/${file#*P}
done
