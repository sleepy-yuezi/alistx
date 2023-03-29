#!/bin/bash
#测试volume
mkdir -p /root/.aria2
cd /root/.aria2
wget https://github.com/P3TERX/aria2.conf/archive/refs/heads/master.tar.gz
tar -zxvf master.tar.gz --strip-components=1
rm -rf master.tar.gz
sed -i 's|rpc-secret|#rpc-secret|g' ./aria2.conf
touch /root/.aria2/aria2.session
./tracker.sh


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
