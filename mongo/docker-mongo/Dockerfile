FROM ampregistry:5000/sng-biz-mongo:3.4.10

ADD ./mongod.conf /data/configdb/mongod.conf
COPY startup.sh /usr/local/bin
RUN chmod -R 777 /usr/local/bin/startup.sh

CMD /usr/local/bin/startup.sh
