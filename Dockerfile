FROM alpine:3.17


ENV SERVER_HOST=
ENV SERVER_PORT=
ENV SERVER_DOMAIN=
ENV TUNNEL_PATH=
ENV UI_PORT=54322
ENV UI_SECRET=overtls
ENV PROXY_PORT=54323
ENV PROXY_USER=overtls
ENV PROXY_PASS=overtls


ENV OVERTLS_USER=overtls
ENV OVERTLS_PASS=overtls
ENV OVERTLS_LOG_LEVEL=debug
ARG SINGBOX_VERSION=1.8.8



RUN apk --no-cache add wget unzip bash && cd / \
 && wget https://github.com/haishanh/yacd/releases/latest/download/yacd.tar.xz \
 && mkdir -p /default/clash/dashboard/ \
 && tar xvf yacd.tar.xz -C /default/clash/dashboard && rm -rf yacd.tar.xz \
 && wget https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db \
 && wget https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db \
 && wget https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite-cn.db \
 && wget -O singbox.tar.gz https://github.com/SagerNet/sing-box/releases/download/v${SINGBOX_VERSION}/sing-box-${SINGBOX_VERSION}-linux-amd64.tar.gz \
 && tar -zxvf singbox.tar.gz -C / && rm -rf singbox.tar.gz && mv /sing-box-${SINGBOX_VERSION}-linux-amd64/sing-box / && rm -rf sing-box-${SINGBOX_VERSION}-linux-amd64 \
 && wget -O overtls.zip https://github.com/shadowsocksr-live/overtls/releases/latest/download/overtls-x86_64-unknown-linux-musl.zip \
 && unzip overtls.zip && rm -rf overtls.zip config.json \
 && mkdir /overtlsclient



VOLUME ["/overtlsclient"]

COPY entrypoint.sh /entrypoint.sh
COPY utils.sh /utils.sh
COPY singbox.json /singbox.json

EXPOSE $PROXY_PORT
EXPOSE $UI_PORT


ENTRYPOINT ["/entrypoint.sh"]
