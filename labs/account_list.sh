#!/bin/bash

geth \
    --datadir $GETH_DATA_PATH \
    --port "30304" \
    account list
