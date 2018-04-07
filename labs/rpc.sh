#!/bin/bash

PASSWORD="/labs/password"

geth \
	--testnet \
	--datadir $GETH_DATA_DIR \
	--password $PASSWORD \
	account new

geth \
	--testnet \
	--etherbase 0 \
	--networkid 7777 \
	--nodiscover \
	--maxpeers 1 \
	--datadir $GETH_DATA_DIR \
	--mine --minerthreads 1 \
	--rpc
