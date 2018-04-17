#!/usr/bin/env bash
SHA=$1
SHASHORT=${SHA:0:8}
data=`docker images | grep $SHASHORT | grep -v mariadb | grep -v mongo | awk '{print $1":"$2}'`
arr=(${data//\\n/ })
for i in ${arr[@]}  
do  
    echo $i
    curl $2 --cookie "$3" > /home/gitlab-runner/logs/$SHASHORT.txt
    sed -i "s!\"image\":\"[^\"]\+\"!\"image\":\"$i\"!g" /home/gitlab-runner/logs/$SHASHORT.txt
    echo -----------------------------------------
    output=`cat /home/gitlab-runner/logs/$SHASHORT.txt`
    echo $output
    curl -X PUT -H "Content-Type: multipart/form-data" --data "$output" $2 --cookie "$3"
    curl -X POST --data operate=deploy $2/operate --cookie "$3"
done
