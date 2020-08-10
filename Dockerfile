#
# Dockerfile for webui-aria2
#

FROM alpine
LABEL maintainer="Ricky Li <cnrickylee@gmail.com>"

ADD entrypoint.sh /entrypoint.sh

RUN set -ex \
 && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
 # Build environment setup
 && apk update \
 && apk add --no-cache --virtual .build-deps \
      git \
 # Build & install
 && export http_proxy=http://nuc.home.test:8118 \
 && export https_proxy=http://nuc.home.test:8118 \
 && git clone https://github.com/ziahamza/webui-aria2.git /webui-aria2 \
 && apk del .build-deps \
 # Runtime dependencies setup
 && apk add --no-cache darkhttpd \
 && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

