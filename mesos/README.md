1. Install
brew install mesos

2. CMD

# start cluster
/usr/local/sbin/mesos-master --registry=in_memory --ip=127.0.0.1
/usr/local/sbin/mesos-slave --master=127.0.0.1:5050
