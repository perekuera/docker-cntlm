FROM alpine

MAINTAINER Pere

LABEL version="0.1.1"

ADD ./cntlm-0.92.3/ /usr/local/src/cntlm-0.92.3/
ADD ./source/cntlm.conf /etc

RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /usr/local/src/cntlm-0.92.3 && ./configure && make && make install \
    && rm -Rf /usr/local/src/cntlm-0.92.3 \
    && apk del --no-cache .build-deps

ADD ./source/setup.sh /usr/local/src

EXPOSE 3128

CMD /usr/local/src/setup.sh
