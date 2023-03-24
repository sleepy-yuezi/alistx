FROM xhofe/alist:latest
LABEL MAINTAINER="i@nn.ci"
VOLUME /opt/alist/data/
WORKDIR /opt/alist/
COPY entrypoint.sh /entrypoint.sh
COPY install.sh /install.sh
RUN chmod +x /entrypoint.sh /install.sh; \
  /install.sh
COPY nginx.conf /etc/nginx/nginx.conf
ENV PUID=0 PGID=0 UMASK=022
EXPOSE 80
ENTRYPOINT [ "/entrypoint.sh" ]
