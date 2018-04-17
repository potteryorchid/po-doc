#!/usr/bin/env bash
cd /home/gitlab-runner
SHA=$3
TAG=$4
LSDATE=`date +%y%m%d%H`
if [ -x "$1/docker/mongodb" ]; then
   cd $1/docker/mongodb
   sudo docker build -t ampregistry:5000/sng-biz-$2-mongodb:$4.$LSDATE-${SHA:0:8}-$5 .
   echo ampregistry:5000/sng-biz-$2-mongodb:$4.$LSDATE-${SHA:0:8}-$5
fi 
