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

    local networkid=7777
    local maxpeers=0

    geth \
        --networkid $networkid \
        --nodiscover --maxpeers $maxpeers \
        --datadir $GETH_DATA_DIR \
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
