# [SIMD types](https://developer.mozilla.org/ja/docs/Web/JavaScript/SIMD_types)

## JavaScriptのSIMD

JavaScriptのSIMDベクトルは128ビットのバイト列で構成される。
例えば関数`SIMD.Float32x4()`は32ビットFloat型の値4つを並べたベクトルを生成する。
同じ演算子での計算の場合、SIMDベクトルの要素同士の計算は同時に行う。

```
var a = SIMD.Float32x4(1, 2, 3, 4);
var b = SIMD.Float32x4(5, 6, 7, 8);
var c = SIMD.Float32x4.add(a,b); // Float32x4[6, 8, 10, 12]
```

## mask

比較関数やカスタムセレクションをつかうことでベクトルの要素をフィルタリングすることができる。

```
var a = SIMD.Float32x4(1, 2, 3, 4);
var b = SIMD.Float32x4(5, 6, 7, 8);

var mask = SIMD.Float32x4.lessThan(a, SIMD.Float32x4.splat(3));
// Int32x4[-1, -1, 0, 0]

var result = SIMD.Float32x4.select(mask,
                                   SIMD.Float32x4.mul(a, b),
                                   SIMD.Float32x4.add(a, b));

console.log(result); // Float32x4[5, 12, 10, 12]
```
