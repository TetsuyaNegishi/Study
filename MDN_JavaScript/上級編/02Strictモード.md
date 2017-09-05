# [Strictモード](https://developer.mozilla.org/ja/docs/Web/JavaScript/Strict_mode)


Strictモードを使用することでJavaScriptの幾つかの機能を制限できる。

- エラーではないが落とし穴になることをエラーが発生するように変更する
- 最適化処理を困難にする誤りを修正する
- 将来のECMAScriptで定義される予定の構文を禁止する

## strictモードの適用

スクリプト全体に適用するには、他のいかなる文よりも前に"use strict"を追加する。

```
"use strict";
var v = "Hi!  I'm a strict mode script!";
```

関数でstrictモードを適用するには、関数本体でいかなる文よりも前に”use strict"を追加する。

```
function strict()
{
  'use strict';
  function nested() { return "And so am I!"; }
  return "Hi!  I'm a strict mode function!  " + nested();
}
```

## ミスからエラーへの変換

代入文によるグローバル変数の作成を防ぐ

```
"use strict";
mistypedVaraible = 17; // throws a ReferenceError
```

通常のコードで暗黙的に失敗する代入 (書き込み不可のプロパティへの代入、getter のみのプロパティへの代入、拡張不可 オブジェクトへの新規プロパティ割り当て)を防ぐ

```
"use strict";

// Assignment to a non-writable property
var obj1 = {};
Object.defineProperty(obj1, "x", { value: 42, writable: false });
obj1.x = 9; // throws a TypeError

// Assignment to a getter-only property
var obj2 = { get x() { return 17; } };
obj2.x = 5; // throws a TypeError

// Assignment to a new property on a non-extensible object
var fixed = {};
Object.preventExtensions(fixed);
fixed.newProp = "ohai"; // throws a TypeError
```

削除できないプロパティを削除するとエラー

```
"use strict";
delete Object.prototype; // throws a TypeError
```

プロパティ名の重複を防ぐ

```
"use strict";
var o = { p: 1, p: 2 }; // !!! syntax error
```

関数の引数名の重複を防ぐ

```
function sum(a, a, c) // !!! syntax error
{
  "use strict";
  return a + b + c; // wrong if this code ran
}
```

8進数表記の禁止

```
"use strict";
var sum = 015 // !!! syntax error
```

## 変数の仕様の単純化

withの禁止

```
"use strict";
var x = 17;
with (obj) // !!! syntax error
{
    x;
}
```

単純名の削除の禁止

```
"use strict";
eval("var x; delete x;"); // !!! syntax error
```

## eval, argumentsの単純化

eval,argumentsという名前に対してバインドや代入を不可

```
// 以下は全てエラー
function x(eval) { }
function arguments() { }
eval = 17;
arguments++;
++eval;
```

arguments.callerの禁止

```
"use strict";
function fun(a, b)
{
  "use strict";
  var v = 12;
  return arguments.caller; // throws a TypeError
}
fun(1, 2); // doesn't expose v (or a or b)
```
