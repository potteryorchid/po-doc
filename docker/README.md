Docker

## Docker 信息 ##

* Docker 安装配置

# 查看 Docker 安装信息
docker info

# 查看 Docker 存储目录
docker info | grep "Docker Root Dir"

# mac 路径
~/.docker/daemon.json

# 修改配置文件，自定义docker存储路径
vi /etc/docker/daemon.json
添加 "graph": "/data1/repo/docker" 自定义docker文件存储路径
{
   ….,
   "graph": "/data1/repo/docker"
}

# 停止 Docker 服务
service docker stop

# 启动 Docker 服务
service docker start


# 镜像私服
docker pull registry
docker run -d -p 5000:5000 -v `pwd`/data/docker/registry:/var/lib/registry --restart=always --name registry registry
5001:5000

# 杀死所有正在运行的容器
docker kill $(docker ps -a -q)

# 删除所有已停止的容器
docker rm $(docker ps -a | grep "Exited" | awk '{print $1}')

# 删除所有未打 ‘dangling’ 标签的镜像
docker rmi $(docker images -q -f dangling=true)

# 批量删除镜像
docker rmi $(docker images | grep "sng-biz-facecompare" | awk '{print $1 ":" $2}')
docker rmi $(docker images | grep "sng-biz-facecompare" | awk '{print $3 }')

# 删除所有镜像
docker rmi $(docker images -q)




/usr/share/i18n/charmaps
docker run -e LANG=C.UTF-8 -it sng-fc-49:4999/sng-biz-facecompare:dev /bin/bash
docker run -it sng-fc-49:4999/sng-biz-facecompare:test /bin/bash

docker run -e UPDATE=UPDATE -e DEVOPS_INFRA_PASSWORD=eU5xhtiY --net=host ampregistry:5000/sng-biz-facecompare-mongodb:1.0.18032616-a60d2176-beta
docker run -it 8abb928406d0 /bin/bash



Mac 路径：/Users/megvii/Library/Containers/com.docker.docker/Data

导出：sudo docker save -o /**/image_tar.tar repository_name:tag_name

导入：sudo docker load -i /**/image_tar.tar

service docker start/stop/restart

docker tag facecompare:1.0.3 ampregistry:5000/facecompare:1.0.5

#  根据镜像启动容器使用主机网络host配置、指定服务端口
docker run -it --net=host facecompare:1.0 java -Dserver.port=9091 -jar facecompare_webboot-1.0-SNAPSHOT.jar

# 启动新容器指定映射端口和ip，CMD 指令添加到命令后面
docker run -p 127.0.0.1:8080:9091 facecompare:1.0 java -jar facecompare_webboot-1.0-SNAPSHOT.jar

# docker 信息
docker info | grep "Docker Root Dir"

# Linux启动
/etc/init.d/docker start

# 网络搜索镜像
docker search image_name

# 下载镜像
docker pull

# 查看本地镜像列表
docker images

# 镜像删除
docker image rm REPOSITORY_NAME:TAG_NAME
docker image rm image_id

# 查看本地所有容器
docker ps -a

# 启动一个新容器并保持远程登录
# -it 解释: -i 表示容器命令终端保持打开状态，-t 表示开启伪终端绑定到打开的容器命令终端
docker run --name container_name -it image_name /bin/bash

# 后端运行 -d
docker run -d --name container_name -it image_name /bin/bash

# 停止容器
docker stop container_id

# 删除容器
docker rm container_id

# 进入容器
docker exec -it container_name /bin/bash

# 进入容器 建议用linux命令 nsenter(表示切换线程命名空间)，若没用该命令安装：yum install -y util-linux
docker inspect --fotmat "{{.State.Pid}}" container_id    # 获取要进入docker容器的pid
nsenter --target container_pid(上面命令获取到pid) --mount --uts --ipc --net --pid    # 通过容器pid进入到容器

# 查看网桥
brctl show

# 网络查看
iptables -t nat -L -n

# 查看路由
ip ro li

# 查看网络
ip ad li

# docker 端口随机映射(端口不冲突，但需要获取随机端口)
docker run -d -P --name container_name image_name

# docker 指定端口映射，语法如下
# -p host_port:container_port
# -p ip:host_port:container_port
# -p ip::container_port
docker run -d -p 91:80 --name container_name imge_name

# 启动新容器指定主机名
docker run --name container_name -h host_name

# 
docker run -it --name container_name -h host_name -v /data image_name

# 查看容器映射卷信息
docker inspect -f {{.Volumes}} container_name

#
docker run -it --name container_name -h host_name -v /host_path:/docker_path image_name


==========================
# 容器run后补充网络配置
# 查看容器配置信息
sudo docker inspect container_id

# 查看容器映射
iptables -t nat -nvL --line-number

# 为容器配置映射端口
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 9020 -j DNAT --to-destination 172.17.0.2:3306
（# 9020代表主机端口号，172.17.0.2代表docker容器ip，3306代表docker容器端口号；）

# 保存ip配置信息
iptables-save
==========================

Containers
================
# 查看所有容器
docker ps -a

docker build -t REPOSITORY_NAME:TAG_NAME .  # Create image using this directory's Dockerfile， "." 表示当前目录

docker run -p 4000:80 friendlyname  # Run "friendlyname" mapping port 4000 to 80

docker run -d -p 4000:80 friendlyname         # Same thing, but in detached mode

docker container ls                                # List all running containers

docker container ls -a             # List all containers, even those not running

docker container stop <hash>           # Gracefully stop the specified container

docker container kill <hash>         # Force shutdown of the specified container

docker container rm <hash>        # Remove specified container from this machine

docker container rm $(docker container ls -a -q)         # Remove all containers

docker image ls -a                             # List all images on this machine

docker image rm <image id>            # Remove specified image from this machine

docker image rm $(docker image ls -a -q)   # Remove all images from this machine

docker login             # Log in this CLI session using your Docker credentials

docker tag <image> username/repository:tag  # Tag <image> for upload to registry

docker push username/repository:tag            # Upload tagged image to registry

docker run username/repository:tag                   # Run image from a registry

Services
================
docker stack ls                                            # List stacks or apps

docker stack deploy -c <composefile> <appname>  # Run the specified Compose file

docker service ls                 # List running services associated with an app

docker service ps <service>                  # List tasks associated with an app

docker inspect <task or container>                   # Inspect task or container

docker container ls -q                                      # List container IDs

docker stack rm <appname>                             # Tear down an application

Swarm
================
docker-machine create --driver virtualbox myvm1 # Create a VM (Mac, Win7, Linux)

docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1 # Win10

docker-machine env myvm1                # View basic information about your node

docker-machine ssh myvm1 "docker node ls"         # List the nodes in your swarm

docker-machine ssh myvm1 "docker node inspect <node ID>"        # Inspect a node

docker-machine ssh myvm1 "docker swarm join-token -q worker"   # View join token

docker-machine ssh myvm1   # Open an SSH session with the VM; type "exit" to end

docker-machine ssh myvm2 "docker swarm leave"  # Make the worker leave the swarm

docker-machine ssh myvm1 "docker swarm leave -f" # Make master leave, kill swarm

docker-machine start myvm1            # Start a VM that is currently not running

docker-machine stop $(docker-machine ls -q)               # Stop all running VMs

docker-machine rm $(docker-machine ls -q) # Delete all VMs and their disk images

docker-machine scp docker-compose.yml myvm1:~     # Copy file to node's home dir

docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"   # Deploy an app



BUG Q&A

# docker: Error response from daemon: service endpoint with name megvii.sng-biz-all.inner-biz.userconfig already exists.

1、docker network ls		// 获取网络配置信息
2、docker network disconnect -f 9eb18e279177 megvii.sng-biz-all.inner-biz.userconfig	// 从对应的网络配置中删除已占用的网络配置信息

