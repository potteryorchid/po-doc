#!/usr/bin/env bash

SHA=$1
SHASHORT=${SHA:0:8}
LSDATE=`date +%y%m%d%H%M%S`
data=`docker images | grep ampregistry | grep $SHASHORT | grep $2 | awk '{print $1":"$2}'`
if [[ "$2" != "mariadb" && "$2" != "mongodb" ]];then
    data=`docker images | grep ampregistry | grep $SHASHORT | grep $2 | grep -v mongodb | grep -v mariadb | awk '{print $1":"$2}'`
fi
arr=(${data//\\n/ })
oldimg=${arr[0]}
echo $oldimg
arr=(${oldimg//$SHASHORT/ })
newimg=${arr[0]}$SHASHORT-$LSDATE${arr[1]}
#newimg=${newimg//ampregistry/registry87.sng.megvii-inc.com};
echo docker tag $oldimg $newimg
docker tag $oldimg $newimg
docker push $newimg
echo "$oldimg -----> $newimg"

#将镜像发布到qa的registry