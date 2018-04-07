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
	--rpc \
    --rpcaddr "0.0.0.0" \
    --rpcport 8545 \
    --rpccorsdomain "*" \
    --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
    --unlock 0 \
    --password $PASSWORD \
    --verbosity 6
    
