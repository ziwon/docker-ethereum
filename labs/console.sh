#!/bin/bash

set -eu pipefail

init() {
    ../entrypoint.sh
}


rinkeby() {
    init 

    geth --rinkeby console
}

nopeers() {
    init

    local network_id=7777
    local max_peers=0

    geth \
        --networkid $network_id \
        --nodiscover --maxpeers $max_peers \
        --datadir $GETH_DATA_PATH \
        console
}

case "$1" in
    testnet)
        $1
        ;;
    rinkeby)
        $1
        ;;
    nopeers)
        $1
        ;;
    *)
        nopeers
        ;;
esac
