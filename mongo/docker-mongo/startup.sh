#!/usr/bin/env bash

if [ -n "$CACHESIZEGB" ] ;
then
    sed -i "s/cacheSizeGB: 32/cacheSizeGB: $CACHESIZEGB/g" /data/configdb/mongod.conf
fi

mongod --config /data/configdb/mongod.conf &
sleep 10
echo "use archives;" > /data/tmp.sh
echo "use admin;" >> /data/tmp.sh
echo "db.dropUser('adminx');" >> /data/tmp.sh
mongo --host 127.0.0.1 < /data/tmp.sh
echo "use admin;" > /data/tmp2.sh
echo "db.createUser({user:'adminx',pwd:'$DEVOPS_INFRA_PASSWORD',roles:[{ role:'root',db:'admin' },{role:'readWrite',db:'archives'},{role:'dbAdmin',db:'archives'},{role:'dbOwner',db:'archives'} ]});" >> /data/tmp2.sh
echo "use archives;" >> /data/tmp2.sh
echo "db.dropUser('adminx');" >> /data/tmp2.sh
echo "db.createUser({user:'adminx',pwd:'$DEVOPS_INFRA_PASSWORD',roles:[{role:'readWrite',db:'archives'},{role:'dbAdmin',db:'archives'},{role:'dbOwner',db:'archives'} ]});" >> /data/tmp2.sh

mongo --host 127.0.0.1 < /data/tmp2.sh
sleep 2
ps aux | grep "mongod" |grep -v grep| cut -c 9-15 | xargs kill -9
sleep 2
mongod --config /data/configdb/mongod.conf --auth
