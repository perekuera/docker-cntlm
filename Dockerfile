FROM alpine

LABEL version="1.0" \
      description="CNTLM Docker image for handling NTLM authentication" \
      maintainer="Pere Bestard"

ARG USERNAME="testuser"
ARG DOMAIN="corp-uk"
ARG PASSWORD="password"
ARG PROXY="10.0.0.41:8080"
ARG NOPROXY=""

ENV USERNAME="${USERNAME}"
ENV DOMAIN="${DOMAIN}"
ENV PASSWORD="${PASSWORD}"
ENV PROXY="${PROXY}"
ENV NOPROXY="${NOPROXY}"

WORKDIR /etc/cntlm

COPY ./src/ /usr/local/src

RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /usr/local/src/cntlm-0.92.3 && ./configure && make && make install \
    && rm -Rf /usr/local/src/cntlm-0.92.3 \
    && apk del --no-cache .build-deps \
    && rm -rf /var/cache/apk/* \
    && chmod +x /usr/local/src/config.sh \
    && /usr/local/src/config.sh \
    && unset USERNAME \
    && unset DOMAIN \
    && unset PASSWORD \
    && unset PROXY \
    && unset NOPROXY;

EXPOSE 3128

ENTRYPOINT cntlm -f -v -c /etc/cntlm/cntlm.conf
