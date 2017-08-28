# [JavaScript「再」入門](https://developer.mozilla.org/ja/docs/Web/JavaScript/A_re-introduction_to_JavaScript)

## 数値

単項演算子+で値を数値に変換できる。

```
+ '42' // 42
+ '010' // 10
```

NaNやInfinityのチェックはisNaN(),isFinite()を使う。
isFinite()は有限数かどうかチェックする。

```
isNaN(NaN);
isFinite(-Infinity); // false
isFinite(NaN); // false
```

## クロージャ

```
function makeAdder(a) {
  return function(b) {
    return a + b;
  };
}
var x = makeAdder(5);
var y = makeAdder(20);
x(6); // 11
y(7); // 27
```

JavaScriptで関数を実行するときには必ず'scope'オブジェクトが作成される。
関数内のローカル変数を保持するオブジェクトで、引数として渡された変数によって初期化される。
'scope'オブジェクトは関数が実行し始めるたびに新しいものが生成される。

makeAdder()が呼び出されたとき、aのプロパティを持つscopeオブジェクトが生成される。
その後、新たに生成された関数を返す。
生成された関数はscopeオブジェクトへの参照を保持する。

JavaScript のオブジェクトシステムが利用するプロトタイプチェーンと同様に、scope オブジェクトはスコープチェーンと呼ばれるチェーンを構成する。
