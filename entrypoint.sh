#!/usr/bin/env bash

echo "Initializing"
geth --datadir $GETH_DATA_PATH init $GETH_DATA_PATH/genesis.json
