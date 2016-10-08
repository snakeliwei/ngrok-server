FROM alpine:edge
MAINTAINER lyndon <snakeliwei@gmail.com>

RUN set -ex \
	&& apk add --no-cache \
		ca-certificates \
		make \
		bash \
		gcc \
		musl-dev \
		openssl \
		go \
		git \
		mercurial \
       && mkdir -p /release

RUN git clone https://github.com/tutumcloud/ngrok.git /ngrok

ADD *.sh /

ENV TLS_KEY **None**
ENV TLS_CERT **None**
ENV CA_CERT **None**
ENV DOMAIN **None**
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

VOLUME ["/ngrok/bin"]

CMD ["/run-server.sh"]
