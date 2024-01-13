FROM alpine

LABEL version="1.0" \
      description="CNTLM Docker image for handling NTLM authentication" \
      maintainer="Pere Bestard"

ARG USERNAME
ARG DOMAIN
ARG PASSWORD
ARG PROXIES

WORKDIR /usr/local/src

COPY ./cntlm-0.92.3 .
COPY ./source .

RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd ./cntlm-0.92.3 && ./configure && make && make install \
    && rm -Rf ./cntlm-0.92.3 \
    && apk del --no-cache .build-deps \
    && rm -rf /var/cache/apk/*
    && ./setup.sh

# ADD ./source/setup.sh /usr/local/src

EXPOSE 3128

#ENTRYPOINT ["sh", "./setup.sh"]
