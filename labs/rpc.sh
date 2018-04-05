#!/bin/bash

PASSWORD="/labs/password"

geth \
	--testnet \
	--datadir $GETH_DATA_PATH \
	--password $PASSWORD \
	account new

geth \
	--testnet \
	--etherbase 0 \
	--networkid 7777 \
	--nodiscover \
	--maxpeers 1 \
	--datadir $GETH_DATA_PATH \
	--mine --minerthreads 1 \
	--rpc
