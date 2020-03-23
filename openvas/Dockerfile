FROM kalilinux/kali-rolling

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    alien \
    xsltproc \
    nsis \
    openssh-client \
    rpm \
    net-tools \
    wget \
    openvas

RUN \
    mv /etc/redis/redis.conf /etc/redis/redis.conf.bak && \
    mv /etc/redis/redis-openvas.conf /etc/redis/redis.conf && \
    mkdir /var/run/redis-openvas && \
    chown -R redis:redis /var/run/redis-openvas && \
    sed -i 's/GSA_ADDRESS=127.0.0.1/GSA_ADDRESS=0.0.0.0/' /etc/default/greenbone-security-assistant && \
    sed -i 's/MANAGER_ADDRESS=127.0.0.1/MANAGER_ADDRESS=0.0.0.0/' /etc/default/openvas-manager && \
    sed -i 's/=$MANAGER_PORT"/=$MANAGER_PORT"\n\[ "$ALLOW_HEADER_HOST" \] \&\& DAEMONOPTS="$DAEMONOPTS --allow-header-host=$ALLOW_HEADER_HOST"/' /etc/default/greenbone-security-assistant && \
    sed -i 's/port 0/port 6379/' /etc/redis/redis.conf

RUN \
    service redis-server start && \
    service greenbone-security-assistant start && \
    service openvas-manager start && \
    service openvas-scanner start && \
    greenbone-nvt-sync && \
    greenbone-scapdata-sync && \
    greenbone-certdata-sync

EXPOSE 9392 9390

COPY start.sh /
RUN echo "NOTSET" > /USER_STATUS

CMD ["/start.sh"]
