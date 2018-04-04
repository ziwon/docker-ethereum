FROM golang:1.9-stretch

LABEL maintainer="yngpil.yoon@gmail.com"

WORKDIR /

ENV GETH_VERSION v1.8.3
ENV GETH_DATA_PATH "/chaindata"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        build-essential \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/go-ethereum && \
    wget https://github.com/ethereum/go-ethereum/archive/$GETH_VERSION.tar.gz && \
    tar -xvf $GETH_VERSION.tar.gz -C /tmp/go-ethereum --strip-components=1 && \
    cd /tmp/go-ethereum && \
    make geth && \
    cp build/bin/geth /usr/local/bin && \
    cd - && \
    rm -rf $GETH_VERSION.tar.gz

COPY . .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
