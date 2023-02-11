#!/usr/bin/env bash

prodir=$1
SHA=$3
LSDATE=`date +%y%m%d%H%M`
cd $prodir/baseimage/component/$6
if [ ! -f "Dockerfile" ];then
  dirs=`ls -l | grep ^d`
  arr=(${dirs//\\s/ })
  dir=${arr[${#arr[*]}-1]}
  cd $dir/$6
  docker build -t ampregistry:5000/$6:$4.$LSDATE-${SHA:0:8}-$5 .
  docker push ampregistry:5000/$6:$4.$LSDATE-${SHA:0:8}-$5
  echo --------  ampregistry:5000/$6:$4.$LSDATE-${SHA:0:8}-$5
else 
  docker build -t ampregistry:5000/$6:$4.$LSDATE-${SHA:0:8}-$5 .
  docker push ampregistry:5000/$6:$4.$LSDATE-${SHA:0:8}-$5
  echo --------  ampregistry:5000/$6:$4.$LSDATE-${SHA:0:8}-$5
fi

#基础镜像打包