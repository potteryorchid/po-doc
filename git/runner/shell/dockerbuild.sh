#!/usr/bin/env bash
prodir=$1
if [ "$2" = "data-sync" ];then
    prodir="$1/sng-data-sync/"
fi
if [ "$2" = "identity-verification" ];then
    prodir="$1/identity_verification/"
fi

cd /home/gitlab-runner
sudo docker run --net=host -v /home/gitlab-runner:/home/gitlab-runner ampregistry:5000/maven:3.5.2-jdk-8 /home/gitlab-runner/shell/java-build.sh $prodir
cd $prodir/docker/
dockerfiles=`ls Dockerfile*`
arr=(${dockerfiles//\\s/ })
cd /home/gitlab-runner
for i in ${arr[@]}
do
   cd /home/gitlab-runner
   targetparent=""
   module=$2
   echo ==================================  $module  ==========
   if [ ${#i} -gt 10 ]; then
        module=${i:11}
        targetparent=${i:11}
   fi
   echo ==================================  $module  ==========   $targetparent
   rm -rf projects/$module
   mkdir projects/$module
   mkdir projects/$module/$module
   cp $prodir/$targetparent/target/*.jar projects/$module/$module
   cp $prodir/docker/$i projects/$module/Dockerfile
   if [ "$module" = "config" ];then
     cp -r projects/configfiles projects/config/configfiles
   fi
   cd projects/$module
root@security-87:/home/gitlab-runner/shell# cat dockerbuild.sh
#!/usr/bin/env bash
prodir=$1
if [ "$2" = "data-sync" ];then
    prodir="$1/sng-data-sync/"
fi
if [ "$2" = "identity-verification" ];then
    prodir="$1/identity_verification/"
fi

cd /home/gitlab-runner
sudo docker run --net=host -v /home/gitlab-runner:/home/gitlab-runner ampregistry:5000/maven:3.5.2-jdk-8 /home/gitlab-runner/shell/java-build.sh $prodir
cd $prodir/docker/
dockerfiles=`ls Dockerfile*`
arr=(${dockerfiles//\\s/ })
cd /home/gitlab-runner
for i in ${arr[@]}
do
   cd /home/gitlab-runner
   targetparent=""
   module=$2
   echo ==================================  $module  ==========
   if [ ${#i} -gt 10 ]; then
        module=${i:11}
        targetparent=${i:11}
   fi
   echo ==================================  $module  ==========   $targetparent
   rm -rf projects/$module
   mkdir projects/$module
   mkdir projects/$module/$module
   cp $prodir/$targetparent/target/*.jar projects/$module/$module
   cp $prodir/docker/$i projects/$module/Dockerfile
   if [ "$module" = "config" ];then
     cp -r projects/configfiles projects/config/configfiles
   fi
   cd projects/$module
   SHA=$3
   LSDATE=`date +%y%m%d%H%M`
   sudo docker build -t ampregistry:5000/sng-biz-$module:$4.$LSDATE-${SHA:0:8}-$5 .
   echo docker image:   ampregistry:5000/sng-biz-$module:$4.$LSDATE-${SHA:0:8}-$5
done