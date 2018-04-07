#!/usr/bin/env bash

echo "Initializing"
geth --datadir $GETH_DATA_DIR init $GETH_DATA_DIR/genesis.json
