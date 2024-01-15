FROM alpine

LABEL version="1.0" \
      description="CNTLM Docker image for handling NTLM authentication" \
      maintainer="Pere Bestard"

ENV USERNAME
ENV DOMAIN
ENV PASSWORD
ENV PROXY
ENV NOPROXY

WORKDIR /etc/cntlm

COPY ./src/* /usr/local/src

RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /usr/local/src/cntlm-0.92.3 && ./configure && make && make install \
    && rm -Rf /usr/local/src/cntlm-0.92.3 \
    && apk del --no-cache .build-deps \
    && rm -rf /var/cache/apk/* \
    && chmod +x /usr/local/src/config.sh \
    && /usr/local/src/config.sh

EXPOSE 3128

ENTRYPOINT cntlm -f -c /etc/cntlm/cntlm.conf
