#!/bin/bash

read -t 120 -p ">>>>>>>>>>>> 程序运行需要的五个参数说明：

==== 生成的文件名称：该文件会保存在该目录下 final 文件夹内，命名规范:mariadb_update_v4.1Tov4.2.sql 或 mongo_update_v4.1Tov4.2.sh；

==== 数据库类型：必须输入 “0” 或 “1”。0 - 代表mariadb；1 - 代表mongo。

==== 合并文件类型：必须输入 “0”、“1” 或 “2”.   0 - 代表表结构修改升级脚本；1 - 数据迁移升级脚本；2 - 脏数据清除升>    级脚本；

==== 选取文件的两个时间标识：起始时间和结束时间，eg：face_mariadb_migrate_2018031319_f44f878f.sql 该文件的时间标识为“2018031319”；



请依次输入五个参数，以空格分开(eg: mariadb_update_v4.1Tov4.2.sql 0 0 2018020117 2018032814)：" fn ft type start end

# 判断参数个数是否正确
if [[ ! -n $fn ]] || [[ ! -n $ft ]] || [[ ! -n $start ]] || [[ ! -n $end ]] || [[ ! -n $type ]];
then
    echo "输入参数不正确，请检查输入参数数量！"
    exit 2
fi

# 判断数据类型参数校验
if [[ "0" != $ft && "1" != $ft ]];
then
    echo '数据库类型必须输入： “0” 或 “1”;    0 -代表mariadb; 1 -代表mongo;'
fi

# 合并文件类型参数校验
if [[ "0" != $type && "1" != $type && "2" != $type ]];
then
    echo '合并文件类型必须输入： “0”、“1” 或 “2”;    0 -表结构修改脚本文件; 1 -数据迁移脚本文件; 2 -脏数据清除脚本文件;'
fi

dir="../final"

# 判断文件存放目录是否存在
if [ ! -d $dir ];
then
    mkdir $dir &&
    chmod -R g+rx $dir
else
    chmod -R g+rx $dir
fi

# 校验文件存在
if [ ! -f $dir/$fn ];
then
    :>$dir/$fn &&
    chmod g+rwx $dir/$fn
fi

count=$(grep -o 'set character_set_database=utf8;' $dir/$fn |wc -l)

echo $count

if [ "0" == $ft -a "0" == $count ];
then
    echo "set character_set_database=utf8;
set character_set_server=utf8;
set names utf8;
" >> $dir/$fn
fi

dir1="../migrate"
file=""

if [ $ft = "0" ];
then
    file="*.sql"
else
    file="*.sh"
fi

if [ $type = "0" ];
then
    if [ $start == $end ];
    then
        ls ../$file | grep $start |xargs -n 1 sed '' >> "$dir/$fn"
    else
        ls ../$file | sed -n /$start/,/$end/p |xargs -n 1 sed '' >> "$dir/$fn"
    fi
elif [ $type = "1" ];
then
    if [ $start == $end ];
    then
        ls $dir1/$file | grep -v "delete" | grep $start |xargs -n 1 sed '' >> "$dir/$fn"
    else
        ls $dir1/$file | grep -v "delete" | sed -n /$start/,/$end/p |xargs -n 1 sed '' >> "$dir/$fn"
    fi
elif [ $type = "2" ];
then
    if [ $start == $end ];
    then
        ls $dir1/$file | grep "delete" | grep $start |xargs -n 1 sed '' >> "$dir/$fn"
    else
        ls $dir1/$file | grep "delete" | sed -n /$start/,/$end/p |xargs -n 1 sed '' >> "$dir/$fn"
    fi
fi

echo "==============================
合并后脚本文件信息:" $fn 
echo "Size:" && ls -l $dir | awk '{print $5}'
echo "=============================="
