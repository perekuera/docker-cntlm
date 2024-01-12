FROM alpine

LABEL version="1.0" \
      description="CNTLM Docker image for handling NTLM authentication" \
      maintainer="Pere Bestard"

ARG USERNAME
ARG DOMAIN
ARG PASSNTLMV2
ARG PROXY

COPY ./cntlm-0.92.3/ /usr/local/src/cntlm-0.92.3/
#COPY ./source/ /usr/local/src/


RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /usr/local/src/cntlm-0.92.3 && ./configure && make && make install \
    && rm -Rf /usr/local/src/cntlm-0.92.3 \
    && apk del --no-cache .build-deps \
    && rm -rf /var/cache/apk/*

# ADD ./source/setup.sh /usr/local/src
# ADD ./source/config.sh /usr/local/src
# ADD ./source/test.sh /usr/local/src
# ADD ./source/* /usr/local/src

EXPOSE 3128

CMD sh /usr/local/src/setup.sh
