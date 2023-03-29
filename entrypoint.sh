#!/bin/bash


chown -R ${PUID}:${PGID} /opt/alist/

umask ${UMASK}

apk update && apk add --no-cache nginx

nginx 

exec su-exec ${PUID}:${PGID} nohup aria2c \
  --enable-rpc \
  --rpc-allow-origin-all \
  --conf-path=/root/.aria2/aria2.conf \
  >/dev/null 2>&1 &

exec su-exec ${PUID}:${PGID} ./alist server --no-prefix
