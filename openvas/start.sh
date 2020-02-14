#!/usr/bin/env bash
set -o nounset # Treat unset variables as an error

USER_STATUS=$(cat /USER_STATUS)
OPENVAS_PASSWORD=${PASSWORD:-admin}

service redis-server start

echo "Testing redis status..."
REDIS_STATUS="$(redis-cli ping)"
while  [ "${REDIS_STATUS}" != "PONG" ];
do
    echo "Redis not yet ready..."
    sleep 1
    REDIS_STATUS="$(redis-cli ping)"
done
echo "Redis ready."

echo "Running OpenVAS..."
service greenbone-security-assistant start && \
service openvas-manager start && \
service openvas-scanner start && \

if [ "$USER_STATUS" = "NOTSET" ];
then
  echo "Setting up user..."
  echo "SET" > /USER_STATUS
  openvasmd --create-user=admin --role=Admin && openvasmd --user=admin --new-password=$OPENVAS_PASSWORD
fi

echo "Reloading NVTs..."
greenbone-nvt-sync
greenbone-scapdata-sync
greenbone-certdata-sync
openvasmd --rebuild

echo "Checking setup..."
openvas-check-setup --v9

tail -F /var/log/openvas/*
