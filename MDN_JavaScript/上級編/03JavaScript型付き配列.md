# [JavaScript 型付き配列](https://developer.mozilla.org/ja/docs/Web/JavaScript/Typed_arrays)

## 型付き配列とArrayオブジェクトの違い

- 型付き配列は生のバイナリデータにアクセスする手段を提供する
- 型付き配列ではisArray()を呼び出すとfalseを返す
- 型付き配列では使えないメソッド(push,popなど)が存在する

## 型付き配列を使用するWebAPI

- FileReader.prototype.readAsArrayBuffer()
    - 指定したBlobまたはFileの内容物の読み取りを開始する
- XMLHttpRequest.prototype.send()
    - 型付き配列とArrayBufferオブジェクトを引数としてサポートしている

## 使用例

16バイト固定長のバッファを作成し、全体が0で初期化されたメモリ領域を確保する。

```
var buffer = new ArrayBuffer(16);
```

バッファ内のデータを32ビット符号付き整数の配列として扱うビューを作成する。

```
var int32View = new Int32Array(buffer);
console.log(int32View.length) // 4
```

通常の配列と同じようにアクセスすることが可能。

```
for (var i = 0; i < int32View.length; i++) {
  int32View[i] = i * 2;
}
```

また同一のバッファに対して複数のビューを持つことも可能。

```
var int16View = new Int16Array(buffer);
for (var i = 0; i < int16View.length; i++) {
  console.log("Entry " + i + ": " + int16View[i]); // 0, 0, 2, 0, 4, 0, 6, 0
}
```
