#!/bin/bash  

str="sng-biz-all.inner-infra,sng-biz-all.inner-init"
arr=(${str//,/ })
LSDATE=`date +%y%m%d%H%M%S`
mkdir /home/gitlab-runner/yamls/$LSDATE
for i in ${arr[@]}
do
  echo $i -------------------------------------------------------------
  java -jar autoqa-1.0-SNAPSHOT.jar /home/gitlab-runner/shell/yamls/$LSDATE $1 $i
done

#自动部署qa环境