FROM zookeeper:3.5.5
RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        iputils-ping \
        net-tools \
        vim; \
    rm -rf /var/lib/apt/lists/*;

ARG DISTRO_NAME=apache-zookeeper-3.5.5-bin
ENV PATH=$PATH:/$DISTRO_NAME/bin

CMD ["zkServer.sh", "start-foreground"]