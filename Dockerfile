FROM golang:1.10 AS build-env

ENV GETH_VERSION v1.8.3
ENV SOLC_VERSION v0.4.21

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
    cd - && \
    rm -rf $GETH_VERSION.tar.gz

RUN mkdir /tmp/solidity && cd /tmp/solidity && \
    wget https://github.com/ethereum/solidity/releases/download/$SOLC_VERSION/solc-static-linux && \
    chmod +x solc-static-linux && \
    cd -


FROM bitnami/minideb:jessie
LABEL maintainer="yngpil.yoon@gmail.com"

ENV GETH_DATA_DIR "/chaindata"

WORKDIR /
COPY --from=build-env /tmp/go-ethereum/build/bin/geth /usr/local/bin
COPY --from=build-env /tmp/solidity/solc-static-linux /usr/local/bin/solc
COPY . .
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
