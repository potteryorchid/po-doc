#!/usr/bin/env bash
cd /home/gitlab-runner
sudo rm -rf projects/$2
mkdir projects/$2
if [ "$4" = "facecompare" ];then
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cp -r $1 projects/$2/$4
else
    echo ----------------
    docker run -v /home/gitlab-runner:/home/gitlab-runner ampregistry:5000/node:9.2.0 /home/gitlab-runner/shell/frontend-build.sh $1
    echo -----------------------------------------------------------------
    ls $1
    rm -rf $1/node_modules
    cp -r $1/$4 projects/$2/$4
fi

cp $1/docker/Dockerfile projects/$2/.
cd projects/$2
SHA=$3
LSDATE=`date +%y%m%d%H%M`
echo $LSDATE
docker build -t ampregistry:5000/$2:$5.$LSDATE-${SHA:0:8}-$6 .
echo ampregistry:5000/$2:$5.$LSDATE-${SHA:0:8}-$6

