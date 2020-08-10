#
# Dockerfile for webui-aria2
#

FROM alpine
LABEL maintainer="Ricky Li <cnrickylee@gmail.com>"

RUN set -ex \
 # Build environment setup
 && apk update \
 && apk add --no-cache --virtual .build-deps \
      git \
 # Build & install
 && git clone https://github.com/ziahamza/webui-aria2.git /webui-aria2 \
 && apk del .build-deps \
 # Runtime dependencies setup
 && apk add --no-cache darkhttpd

ENTRYPOINT ["darkhttpd"]
CMD ["/webui-aria2/docs --port 80"]

