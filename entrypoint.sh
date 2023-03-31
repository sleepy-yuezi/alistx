#!/bin/bash

if [ ! -d "/root/.aria2" ]; then
    mkdir -p /root/.aria2
    cd /root/.aria2
    wget https://github.com/P3TERX/aria2.conf/archive/refs/heads/master.tar.gz
    tar -zxvf master.tar.gz --strip-components=1
    rm -rf master.tar.gz
    sed -i 's|rpc-secret|#rpc-secret|g' ./aria2.conf
    touch /root/.aria2/aria2.session
    ./tracker.sh
else
    # 如果目录存在，则输出一条消息并继续执行脚本
    echo "目录 /root/.aria2 已经存在，volume可能已经挂载"
fi
 

chown -R ${PUID}:${PGID} /opt/alist/

umask ${UMASK}

nginx 

exec su-exec ${PUID}:${PGID} nohup aria2c \
  --enable-rpc \
  --rpc-allow-origin-all \
  --conf-path=/root/.aria2/aria2.conf \
  >/dev/null 2>&1 &

exec su-exec ${PUID}:${PGID} ./alist server --no-prefix
