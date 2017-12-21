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
