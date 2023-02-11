#!/bin/bash

echo -n ">>>>>>>>>>>>>"
echo -ne "\033[37;31;5m start... \033[39;49;0m"
echo "<<<<<<<<<<<<<"

echo -e "\e[1;35m 功能选项： \e[0m"
echo -e "\e[1;35m 1.ssh \e[0m"

if read -t 20 -p "20秒内输入功能代表数字: " func ;then
    if read -t 10 -p "选择登录主机 -> 57 73 61 63 65: " host ; then
        hosts=(57 73 61 63 65)
        inHosts=0
        echo "${hosts[@]}" | grep -wq "${host}" && inHosts=${host}
        if [ $inHosts -ne 0 ]; then
            /usr/bin/ssh deployer@10.124.194.$inHosts
        fi
    fi
else    
    echo ">>>>>>>>>>>>> end <<<<<<<<<<<<<"
fi