Gethの初期化コマンド

```
$ geth --datadir ~/Study/ethereum/data_testnet init ~/Study/ethereum/data_testnet/genesis.json 
```

Gethの起動

```
$ geth --networkid 4649 --nodiscover --maxpeers 0 --datadir ~/Study/ethereum/data_testnet/ console 2>> ~/Study/ethereum/data_testnet/geth.log
```

Gethコンソールでアカウントの作成(EOA)

```
> personal.newAccount("pass0")
"0xb7beaf06361c07bb4603e09fff3685ee532e346b"
> eth.accounts
["0xb7beaf06361c07bb4603e09fff3685ee532e346b"]
```

コマンドでアカウントの作成(EOA)

```
$ geth --datadir ~/Study/ethereum/data_testnet/ account new

$ geth --datadir ~/Study/ethereum/data_testnet/ account list
```

Etherbase(マイニング成功時にEtherを受け取るアカウント)の確認と切り替え

```
> eth.coinbase
"0xb7beaf06361c07bb4603e09fff3685ee532e346b"
> miner.setEtherbase(eth.accounts[1])
true
> eth.coinbase
"0x4b6deb79710234efd6ef279a14de9820fa941ac4"
> miner.setEtherbase(eth.accounts[0])
true
> eth.coinbase
"0xb7beaf06361c07bb4603e09fff3685ee532e346b"
```

残高確認

```
> eth.getBalance(eth.accounts[0])
0
```

ブロックチェーンのブロック数確認

```
> eth.blockNumber
0
```

マイニングの実行

```
> miner.start(1)  // 引数はマイニングを行うスレッド数
null
> eth.mining
true
```

マイニングの停止

```
> miner.stop()
true
> eth.mining
false
```

残高確認

```
> eth.getBalance(eth.coinbase) // wei単位
2.578e+22
> web3.fromWei(eth.getBalance(eth.coinbase)) // ether単位
25780
```

アカウントのアンロック

```
> personal.unlockAccount(eth.accounts[0])
Unlock account 0xb7beaf06361c07bb4603e09fff3685ee532e346b
Passphrase:
true
```

トランザクションの発行(トランザクションを発行しただけでは送金されない → マイニングでブロックに含められる必要がある)

```
> eth.sendTransaction({from: eth.accounts[0], to: eth.accounts[1], value: web3.toWei(10,"ether") })
"0x4caf132e8dc3abeb7ecb57995caec60439170177cc34faf509d6bbc48467be21"
> eth.getBalance(eth.accounts[1])
0
> eth.getTransaction("0x4caf132e8dc3abeb7ecb57995caec60439170177cc34faf509d6bbc48467be21")
{
  blockHash: "0x0000000000000000000000000000000000000000000000000000000000000000",
  blockNumber: null,
  from: "0xb7beaf06361c07bb4603e09fff3685ee532e346b",
  gas: 90000,
  gasPrice: 18000000000,
  hash: "0x4caf132e8dc3abeb7ecb57995caec60439170177cc34faf509d6bbc48467be21",
  input: "0x",
  nonce: 0,
  r: "0xe4ce992edc83f0d6fe33f6805e7580115e84d67db75183236ebf3650275f3b7e",
  s: "0x5c7faa24a1bb35911ddb5bd6c72762f14f334d614fff6ecf9aa14d94dd6fc2b8",
  to: "0x4b6deb79710234efd6ef279a14de9820fa941ac4",
  transactionIndex: 0,
  v: "0x1c",
  value: 10000000000000000000
}
```

ペンディング(保留)のトランザクションの確認

```
> eth.pendingTransactions
[{
    blockHash: null,
    blockNumber: null,
    from: "0xb7beaf06361c07bb4603e09fff3685ee532e346b",
    gas: 90000,
    gasPrice: 18000000000,
    hash: "0x4caf132e8dc3abeb7ecb57995caec60439170177cc34faf509d6bbc48467be21",
    input: "0x",
    nonce: 0,
    r: "0xe4ce992edc83f0d6fe33f6805e7580115e84d67db75183236ebf3650275f3b7e",
    s: "0x5c7faa24a1bb35911ddb5bd6c72762f14f334d614fff6ecf9aa14d94dd6fc2b8",
    to: "0x4b6deb79710234efd6ef279a14de9820fa941ac4",
    transactionIndex: 0,
    v: "0x1c",
    value: 10000000000000000000
}]
```

マイニング後のトランザクションの確認(blockHash, blockNumberに値が入る)

```
> eth.getTransaction("0x4caf132e8dc3abeb7ecb57995caec60439170177cc34faf509d6bbc48467be21")
{
  blockHash: "0xdd2ba15b45eb60128953f9c524d6d9bd040cfe64d8f120b84981b71da749af90",
  blockNumber: 5157,
  from: "0xb7beaf06361c07bb4603e09fff3685ee532e346b",
  gas: 90000,
  gasPrice: 18000000000,
  hash: "0x4caf132e8dc3abeb7ecb57995caec60439170177cc34faf509d6bbc48467be21",
  input: "0x",
  nonce: 0,
  r: "0xe4ce992edc83f0d6fe33f6805e7580115e84d67db75183236ebf3650275f3b7e",
  s: "0x5c7faa24a1bb35911ddb5bd6c72762f14f334d614fff6ecf9aa14d94dd6fc2b8",
  to: "0x4b6deb79710234efd6ef279a14de9820fa941ac4",
  transactionIndex: 0,
  v: "0x1c",
  value: 10000000000000000000
}
```

送金の確認

```
> eth.getBalance(eth.accounts[1])
10000000000000000000
> web3.fromWei(eth.getBalance(eth.accounts[1]))
10
```

トランザクションの手数料(accounts[1]の残高が少ない → マイニングをしたアカウントに送金手数料が与えられる)

```
> eth.sendTransaction({from: eth.accounts[1] to: eth.accounts[2], value: web3.toWei(5,"ether")})
"0x92cb0f7d2a1d5737f5d346fa09ce818f3bdcd0b1e00f19152e4f756503b1282b"
> miner.start(1)

略

> eth.getBalance(eth.accounts[2])
5000000000000000000
> eth.getBalance(eth.accounts[1])
4999622000000000000
> eth.getBalance(eth.accounts[0])
2.5835000378e+22
```

別のターミナルからアクセスする

```
$ geth --networkid 4649 --nodiscover --maxpeers 0 --datadir ~/Study/ethereum/data_testnet/ --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin, db, eth, debug, miner, net, shh, txpool, personal, web3" 2>> ~/Study/ethereum/data_testnet/geth.log
```

```
$ geth attach http://localhost:8545
```

JSON-RPCでネットワークにアクセスする

```
$ curl -X POST localhost:8545 -H "Content-Type: application/json" -d '{"jxonrpc":"2.0", "method":"eth_mining", "params":[], "id":10}' // methodとparamsの値を変えるとコンソールと同じように操作できる
{"jsonrpc":"2.0","id":10,"result":true}
```
