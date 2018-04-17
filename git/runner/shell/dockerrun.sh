#!/usr/bin/env bash
SHA=$1
SHASHORT=${SHA:0:8}
data=`docker images | grep $SHASHORT | awk '{print $1":"$2}'`
arr=(${data//\\n/ })
for i in ${arr[@]}  
do  
    docker run -it --net:host $i
done
