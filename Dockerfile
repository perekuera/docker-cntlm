FROM alpine

LABEL version="1.0" \
      description="CNTLM Docker image for handling NTLM authentication" \
      maintainer="Pere Bestard"

ENV USERNAME
ENV DOMAIN
ENV PASSWORD
ENV PROXY
ENV NOPROXY

WORKDIR /usr/local/src

COPY ./cntlm-0.92.3 /usr/local/src
COPY ./source/*.sh .

RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /usr/local/src/cntlm-0.92.3 && ./configure && make && make install \
    && rm -Rf ./cntlm-0.92.3 \
    && apk del --no-cache .build-deps \
    && rm -rf /var/cache/apk/* \
    && chmod +x ./build.sh \
    && ./build.sh

EXPOSE 3128

ENTRYPOINT ["sh", "./init.sh"]
