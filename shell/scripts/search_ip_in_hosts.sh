#!/bin/bash
read -t 20 -p $'please input ip:\x0a' ip
# -n pan duan bian liang zhi shi fou wei kong
[ -n "`grep "\<$ip\>" /etc/hosts`" ] &&\
# \<$ip\> dai biao jing que guo lv
echo -e ">>> Founded hostnames show as below:\n`grep "\<$ip\>" /etc/hosts | awk '{print $2}'`" ||\
echo ">>> The $ip you input is not exist."
