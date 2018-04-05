# docker-ethereum

[![](https://images.microbadger.com/badges/image/ziwon/docker-ethereum.svg)](https://microbadger.com/images/ziwon/docker-ethereum "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/ziwon/docker-ethereum.svg)](https://microbadger.com/images/ziwon/docker-ethereum "Get your own version badge on microbadger.com")


## Build
```
make build TAG=0.1
```


## Run
Activate geth console

```
make run entrypoint=/labs/console.sh
```

## Deploy
```
make push TAG=0.1
```

## Examples
Activate HTTP-RPC server

```
make run ENTRYPOINT=/labs/rpc.sh ARGS="-p 8545:8545"
```

Connect to the Server via geth console

```
make debug COMMAND=/labs/client.sh
```
