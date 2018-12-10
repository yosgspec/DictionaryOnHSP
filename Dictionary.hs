;--------------------------------------------------
; 【連想配列】Dictionaryモジュール
;                                   by.YOS G-spec
; https://github.com/yosgspec/DictionaryOnHSP
;--------------------------------------------------

%dll
Dictionary

%ver
3.5

%date
2018/12/8

%author
YOS G-spec

%url
https://github.com/yosgspec/DictionaryOnHSP

%note
連想配列モジュール
Dictionary.asをインクルードすること。

%type
ユーザー定義命令/関数

%port
Win
Mac
Cli
HSP3Dish
%index
#define DictionaryAliasOff
連想配列モジュールのエイリアスを無効化

%inst
連想配列モジュールのインクルード前に宣言するとdcから始まる定義を全て無効化します。
その場合次の対応に従って命令/関数を呼び出す必要があります。

エイリアス         : 実際の命令/関数名
-------------------:-----------------------------
dcGetHashCode      : getHashCode@Dictionary
dcNull             : null@Dictionary
dcCount            : count@Dictionary
dcGetType          : getType@Dictionary
dcGetTableSize     : getTableSize@Dictionary
dcForeach          : foreach@Dictionary
dcKeys             : keys@Dictionary
dcValues           : values@Dictionary
dcRefKeys          : refKeys@Dictionary
dcRefValues        : refValues@Dictionary
dcRefKeysAndValues : refKeysAndValues@Dictionary
dcJoinArray        : joinArray@Dictionary
dcJoinDict         : joinDict@Dictionary
dcSet              : set@Dictionary
dcAdd              : add@Dictionary
dcReSet            : reSet@Dictionary
dcItem             : item@Dictionary
dcRefItem          : refItem@Dictionary
dcTryGetValue      : tryGetValue@Dictionary
dcRemove           : remove@Dictionary
dcClear            : clear@Dictionary
dcContainsKey      : containsKey@Dictionary
dcContainsValue    : containsValue@Dictionary
dcFinalize         : finalize@Dictionary

%sample
#define DictionaryAliasOff
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

// mes dcItem(dict, "name") // 無効化
mes item@Dictionary(dict, "name")


// エイリアスもどき
#define global ctype dc(%1) %1@Dictionary

mes dc(item)(dict, "name")

%href
new@Dictionary
news@Dictionary
dcGetHashCode
dcNull
dcCount
dcGetType
dcGetTableSize
dcForeach
dcKeys
dcValues
dcRefKeys
dcRefValues
dcRefKeysAndValues
dcJoinArray
dcJoinDict
dcSet
dcAdd
dcReSet
dcItem
dcRefItem
dcTryGetValue
dcRemove
dcClear
dcContainsKey
dcContainsValue
dcFinalize

%group
連想配列の定義
%index
dcAdd
連想配列に要素を追加

%prm
dict, key, value
dict  : 連想配列のモジュール型変数
key   : 登録するキー(文字列)
value : 登録する値
        (型は連想配列の型(dcGetType)で登録されるが、
         文字列、浮遊小数点、文字列間は各自変換される)

%inst
連想配列のキーに値をセットします。
dcSetとは異なり、重複される値は登録されません。
ラベル型、モジュール型の場合は型が異なると失敗します。

処理の結果はstatに代入され、下記のようになります。

stat : 状態
-----:----------------------------------------------
 0   : 正常に処理が完了した
 1   : キーが既に登録されているため、処理に失敗した
 2   : 型が異なるため処理に失敗した
     : (ラベル型、モジュール型のみ)


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにadd@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict
dcAdd dict, "name", "bob"
if stat: mes {"既にキー"name"は存在しています。"}
mes dcItem(dict, "name")

dcAdd dict, "name", "taro"
if stat: mes {"既にキー"name"は存在しています。"}
mes dcItem(dict, "name")


new@Dictionary ldict, "label"
ldim item, 0
dcAdd ldict, "name", *ken
if stat = 2 {
	mes "型が違います。"
}
else {
	dcRefItem ldict, "name", item
	gosub item
}

dcAdd ldict, "name", "taro"
if stat = 2 {
	mes "型が違います。"
}
else {
	dcRefItem ldict, "name", item
	gosub item
}

stop

*ken: mes "ken": return

%href
dcSet
dcReSet
dcRemove
dcItem
dcRefItem
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の変更
%index
dcClear
連想配列から全ての要素を削除

%prm
dict
dict : 連想配列のモジュール型変数

%inst
連想配列に登録される要素を全て削除します。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにclear@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes "【dcClear前】"
mes dcJoinDict(dict)

dcClear dict

mes "【dcClear後】"
mes dcJoinDict(dict)

%href
dcRemove
dcFinalize
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の変更
%index
dcContainsKey
連想配列にキーが存在するか確かめる

%prm
(dict, key)
val=0,1 : キーの存在の可否(0=失敗,1=成功)
dict    : 連想配列のモジュール型変数
key     : 存在を確認するキー(文字列)

%inst
連想配列にキーが存在するか確かめます。

連想配列にキーが存在している場合は1を返し、 
存在していない場合は0を返します。 


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにcontainsKey@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

if dcContainsKey(dict, "name") {
	mes "キーは存在します。"
}
else {
	mes "キーは存在しません。"
}

if dcContainsKey(dict, "hsp") {
	mes "キーは存在します。"
}
else {
	mes "キーは存在しません。"
}


%href
dcAdd
dcTryGetValue
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
状態の取得
%index
dcContainsValue
連想配列に値が存在するか確かめる

%prm
(dict, value)
val=0,1 : キーの存在の可否(0=失敗,1=成功)
dict    : 連想配列のモジュール型変数
value   : 存在を確認する値
          (文字列または文字列に変換した整数、浮遊小数点)

%inst
値が存在するか確かめます(線形探索)。
整数、浮遊小数点の値を探す場合でも文字列に変換して与えてください。

連想配列に値が存在している場合は1を返し、 
存在していない場合は0を返します。 


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにcontainsValue@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

if dcContainsValue(dict, "bob") {
	mes "値は存在します。"
}
else {
	mes "値は存在しません。"
}

if dcContainsValue(dict, "taro") {
	mes "値は存在します。"
}
else {
	mes "値は存在しません。"
}

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
状態の取得
%index
dcCount
連想配列の要素数

%prm
(dict)
val  : 連想配列の要素数(整数)
dict : 連想配列のモジュール型変数

%inst
連想配列に登録されている要素数を返します。 


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにcount@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes dcCount(dict)

%href
repeat
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
状態の取得
%index
dcFinalize
連想配列の消去

%prm
dict
dict : 連想配列のモジュール型変数

%inst
連想配列のモジュール型変数を削除します。
delmodと同一です。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにfinalize@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"name:bob"}

mes dcItem(dict, "name")

dcFinalize dict

// mes dcItem(dict, "name")
// #Error 36 in line 170 (Dictionary.as)
// -->モジュール変数の指定が無効です

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff
delmod

%group
連想配列の定義

%index
dcForeach
連想配列の要素数だけ繰り返す

%prm
dict
dict : 連想配列のモジュール型変数

%inst
repeat/foreachキーワードの代わりに使用します。
配列変数に格納されている要素の数だけ繰り返しを行ないます。
要素のインデックスを順番に取得します。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにforeach@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

dcForeach dict
	mes dcKeys(dict, cnt) + ":" + dcValues(dict, cnt)
loop

%href
repeat
foreach
loop
break
continue
dcKeys
dcValues
dcRefKeys
dcRefValues
dcRefKeysAndValues
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
ユーティリティ
%index
dcGetHashCode
連想配列のハッシュ関数

%prm
(hashStr)
val=0～ : 得られたハッシュ値(整数)
hashStr : ハッシュ化する文字列

%inst
連想配列で使用するハッシュ関数です。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにgetHashCode@Dictionaryを使用します。

%sample
#include "Dictionary.as"

mes dcGetHashCode("あいうえお")

%href
dcItem
dcRefItem
dcAdd
dcSet
dcReSet
dcRemove
dcKeys
dcRefKeys
dcContainsKey
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
ユーティリティ
%index
dcGetTableSize
ハッシュテーブルのサイズ

%prm
(dict)
val=32～ : ハッシュテーブルのサイズ(整数)
dict     : 連想配列のモジュール型変数

%inst
連想配列に使われるハッシュテーブルのサイズを取得します。  
ハッシュテーブルのサイズは必要に応じて自動で拡張されます。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにgetTableSize@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes dcGetTableSize(dict)

repeat 50
	dcAdd dict, "cnt:" + cnt, str(cnt)
loop

mes dcGetTableSize(dict)

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
状態の取得
%index
dcGetType
連想配列の型

%prm
(dict)
val=1～6 : 連想配列の型を示す整数(vartype参照)
dict     : 連想配列のモジュール型変数

%inst
連想配列に登録している型を返します。
型はモジュール型変数の初期化時のみ指定できます。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにgetType@Dictionaryを使用します。

%sample
#include "Dictionary.as"

dimtype dicts, vartype("struct")

news@Dictionary dicts,"int"
news@Dictionary dicts,"double"
news@Dictionary dicts,"str"
news@Dictionary dicts,"label"
news@Dictionary dicts,"struct"

foreach dicts
	v=dcGetType(dicts.cnt)
	if v = 1: mes "ラベル型"
	if v = 2: mes "文字列型"
	if v = 3: mes "実数型"
	if v = 4: mes "整数型"
	if v = 5: mes "モジュール型"
	if v = 6: mes "COMオブジェクト型"
loop

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
状態の取得

%index
dcItem
連想配列から要素を取得

%prm
(dict, key)
val  : 取得した値(整数、浮遊小数点、文字列)
dict : 連想配列のモジュール型変数
key  : 取得する要素のキー

%inst
連想配列から要素を取得します。
見つからなかった場合はdcNullが返ります。

ラベル型やモジュール型の値取得したい場合は、参照返し版のdcRefItemを使用してください。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにitem@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes dcItem(dict, "name")
mes dcItem(dict, "age")
mes dcItem(dict, "hobby")
mes dcItem(dict, "work")

%href
dcRefItem
dcTryGetValue
dcAdd
dcSet
dcReSet
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得
%index
dcJoinArray
配列の結合

%prm
(ary, sep)
val : 配列を結合した文字列
ary : 結合する配列変数  
sep : 区切り文字列  

%inst
配列を区切り文字で結合して文字列を返します。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにjoinArray@Dictionaryを使用します。

%sample
#include "Dictionary.as"

ary = "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"

mes dcJoinArray(ary)

%href
#define DictionaryAliasOff

%group
ユーティリティ
%index
dcJoinDict
連想配列の結合

%prm
(dict, keySep, itemSep)
val     : 連想配列を結合した文字列
dict    : 連想配列のモジュール型変数
keySep  : キーと値の間の区切り文字列
itemSep : 要素ごとの区切り文字列

%inst
連想配列を区切り文字で結合して文字列を返します。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにjoinDict@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes dcJoinDict(dict)

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
ユーティリティ
%index
dcKeys
連想配列のインデックスからキーを取得

%prm
(dict, index)
val   : 取得したキー(文字列)
dict  : 連想配列のモジュール型変数
index : 連想配列に登録される要素のインデックス

%inst
連想配列のインデックスに登録されているキーを取得します。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにkeys@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes strf("%s:%s", dcKeys(dict, 0), dcValues(dict, 0))
mes strf("%s:%s", dcKeys(dict, 2), dcValues(dict, 2))

%href
dcValues
dcRefKeys
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得
%index
dcNull
連想配列で空を示す定数

%inst
連想配列モジュールにて空を示す定数です。
dcItemにて要素が見つからなかったときに本値が返ります。

なお、dcNullの値は"__$dcNull__"と定義されています。


#define DictionaryAliasOffを使用した場合は、
本定数は使用できなくなり、代わりにnull@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict

mes dcNull
mes dcItem(dict, "ないよ")
mes dcNull = dcItem(dict, "ないよ")

%href
dcItem
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
ユーティリティ

%index
dcRefItem
連想配列から要素を取得(参照渡し)

%prm
dict, key, refValue
dict     : 連想配列のモジュール型変数
key      : 要素のキー
refValue : 値を返す変数
           (型はdcGetTypeで得られるものに等しい)

%inst
dcItemの参照渡し版です。
連想配列から要素を取得します。
見つからなかった場合はdcNullが返ります。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにrefItem@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,"label"
dcAdd dict, "name", *name
dcAdd dict, "age", *age
dcAdd dict, "hobby", *hobby
dcAdd dict, "work", *work

ldim fn,0
dcRefItem dict, "name", fn
gosub fn
dcRefItem dict, "age", fn
gosub fn
dcRefItem dict, "hobby", fn
gosub fn
dcRefItem dict, "work", fn
gosub fn

stop

*name: mes "bob": return
*age: mes "40": return
*hobby: mes "読書": return
*work: mes "平社員": return

%href
dcItem
dcTryGetValue
dcAdd
dcSet
dcReSet
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得

%index
dcRefKeys
連想配列からキーの配列を取得

%prm
dict, refKeys
dict    : 連想配列のモジュール型変数
refKeys : キーの配列を返す文字列配列変数

%inst
連想配列から登録されているキーの配列を取得します。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにrefKeys@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,"label"
dcAdd dict, "name", *name
dcAdd dict, "age", *age
dcAdd dict, "hobby", *hobby
dcAdd dict, "work", *work

sdim keys
dcRefKeys dict, keys
ldim values, 0
dcRefValues dict, values

foreach keys
	mes keys(cnt)+":"
	gosub values(cnt)
loop

stop

*name: mes "bob": return
*age: mes "40": return
*hobby: mes "読書": return
*work: mes "平社員": return

%href
dcKeys
dcRefValues
dcRefKeysAndValues
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得
%index
dcRefKeysAndValues
連想配列からキーと値の配列を取得

%prm
dict, refKeys, refValues  
dict      : 連想配列のモジュール型変数
refKeys   : キーの配列を返す文字列配列変数
refValues : 値の配列を返す配列変数
            (型はdcGetTypeで得られるものに等しい)

%inst
連想配列から登録されているキーと値の配列を取得します。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにrefKeysAndValues@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,"label"
dcAdd dict, "name", *name
dcAdd dict, "age", *age
dcAdd dict, "hobby", *hobby
dcAdd dict, "work", *work

sdim keys
ldim values, 0
dcRefKeysAndValues dict, keys, values

foreach keys
	mes keys(cnt)+":"
	gosub values(cnt)
loop

stop

*name: mes "bob": return
*age: mes "40": return
*hobby: mes "読書": return
*work: mes "平社員": return

%href
dcRefKeys
dcRefValues
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得
%index
dcRefValues
連想配列から値の配列を取得

%prm
dict, refValues
dict      : 連想配列のモジュール型変数
refValues : 値の配列を返す配列変数
            (型はdcGetTypeで得られるものに等しい)

%inst
登録されている値の配列を取得します。


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにrefValues@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,"label"
dcAdd dict, "name", *name
dcAdd dict, "age", *age
dcAdd dict, "hobby", *hobby
dcAdd dict, "work", *work

sdim keys
dcRefKeys dict, keys
ldim values, 0
dcRefValues dict, values

foreach keys
	mes keys(cnt)+":"
	gosub values(cnt)
loop

stop

*name: mes "bob": return
*age: mes "40": return
*hobby: mes "読書": return
*work: mes "平社員": return

%href
dcValues
dcRefKeys
dcRefKeysAndValues
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得
%index
dcRemove
連想配列から要素を削除

%prm
dict, key
dict : 連想配列のモジュール型変数
key  : 削除する要素のキー

%inst
連想配列から要素を削除します。

処理の結果はstatに代入され、下記のようになります。

stat : 状態
-----:------------------------------------
 0   : 正常に処理が完了した
 1   : キーが存在しないため処理に失敗した


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにremove@Dictionaryを使用します。

%sample
#runtime "hsp3cl"
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes "【dcRemove前】"
mes dcJoinDict(dict)

dcRemove dict, "hobby"
dcRemove dict, "work"

mes "【dcRemove後】"
mes dcJoinDict(dict)

%href
dcAdd
dcSet
dcReSet
dcRemove
dcClear
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の変更
%index
dcReSet
連想配列の要素に演算を適用して再代入

%prm
dict, key, sign, addValue 
dict     : 連想配列のモジュール型変数
key      : 演算を適用する要素のキー
sign     : 演算子を示す文字列(下記参照)
addValue : 演算を行う値(整数、浮遊小数点、文字列)

%inst
代入演算子に相当する命令です。
設定した演算子と値を適用して再代入します。

演算子を示す文字列は次の対応となります。

演算子 : 文字列
-------:--------
  +    : "+"
  -    : "-"
  *    : "*"
  /    : "/"
  \    : "\\"
  |    : "|"
  &    : "&"
  ^    : "^"
  <<   : "<<"
  >>   : ">>"

処理の結果はstatに代入され、下記のようになります。

stat : 状態
-----:-------------------------------------------
 0   : 正常に処理が完了した
 1   : キーが見つからなかった、
     : または演算子を示す文字列が不正であるため、
     : 処理に失敗した


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにreSet@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,"int"

dcSet dict, "num", 16
mes dcItem(dict, "num")

dcReSet dict, "num","*", 2
mes dcItem(dict, "num")

dcReSet dict, "num","-", 64
mes dcItem(dict, "num")

%href
dcSet
dcAdd
dcItem
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の変更
%index
dcSet
連想配列の要素に値を代入

%prm
dict, key, value
dict  : 連想配列のモジュール型変数
key   : 登録するキー(文字列)
value : 登録する値
        (型は連想配列の型(dcGetType)で登録されるが、
         文字列、浮遊小数点、文字列間は各自変換される)

%inst
連想配列のキーに値をセットします。
ラベル型、モジュール型の場合は型が異なると失敗します。

処理の結果はstatに代入され、下記のようになります。

stat : 状態
-----:------------------------------
 0   : 正常に処理が完了した
 2   : 型が異なるため処理に失敗した
     : (ラベル型、モジュール型のみ)


#define DictionaryAliasOffを使用した場合は、
本命令は使用できなくなり、代わりにset@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict

dcSet dict, "name", "bob"
mes dcItem(dict, "name")

dcSet dict, "name", "taro"
mes dcItem(dict, "name")

new@Dictionary ldict, "label"
ldim item, 0
dcSet ldict, "name", *ken
if stat = 2 {
	mes "型が違います。"
}
else {
	dcRefItem ldict, "name", item
	gosub item
}

dcSet ldict, "name", "taro"
if stat = 2 {
	mes "型が違います。"
}
else {
	dcRefItem ldict, "name", item
	gosub item
}

stop

*ken: mes "ken": return

%href
dcAdd
dcReSet
dcRemove
dcItem
dcRefItem
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の変更
%index
dcTryGetValue
連想配列から要素の取得を試す

%prm
(dict, key, refValue)
val=0,1 : 要素の取得の可否(0=失敗,1=成功)
dict : 連想配列のモジュール型変数
refValue : 値を返す変数
           (型はdcGetTypeで得られるものに等しい)

%inst
連想配列から要素を取得できるか試します。
取得できた場合は1を返し、refValueに値を返します。  
できなかった場合は0を返します。 


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにtryGetValue@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

keys = "name", "age", "hobby", "work", "hsp"
sdim item
foreach keys
	if dcTryGetValue(dict, keys(cnt), item) {
		mes item
	}
	else {
		mes "要素が見つかりませんでした。"
	}
loop

%href
dcItem
dcRefItem
dcContainsKey
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得

%index
dcValues
連想配列のインデックスから値を取得

%prm
(dict, index)
val   : 取得した値(型はdcGetTypeで得られるものに等しい)
dict  : 連想配列のモジュール型変数
index : 連想配列に登録される要素のインデックス

%inst
連想配列のインデックスに登録されている値を取得します。

ラベル型やモジュール型の値取得したい場合は、配列取得版のdcRefValuesを使用してください。


#define DictionaryAliasOffを使用した場合は、
本関数は使用できなくなり、代わりにvalues@Dictionaryを使用します。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes strf("%s:%s", dcKeys(dict, 0), dcValues(dict, 0))
mes strf("%s:%s", dcKeys(dict, 2), dcValues(dict, 2))

%href
dckeys
dcRefValues
dcRefKeysAndValues
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
要素の取得
%index
new@Dictionary
連想配列の初期化

%prm
dict, type, keySep, itemSep, initDict
dict        : 初期化する連想配列(モジュール型変数で返る)
type="str"  : 型を示す文字列(vartype参照)
keySep=":"  : initDictのキーと値の間の区切り文字
itemSep="," : initDictの要素ごとの区切り文字
initDict    : 連想配列に設定する初期値(文字列)

%inst
連想配列モジュールを初期化し、連想配列のモジュール型変数を生成します。
(Dictionaryモジュールコンストラクタ)

連想配列を配列変数に格納する場合は初期化時に配列変数が破棄されるため、news@Dictionaryをご使用ください。

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:読書,
	work:平社員
"}

mes dcItem(dict, "name")
mes dcItem(dict, "age")
mes dcItem(dict, "hobby")
mes dcItem(dict, "work")

%href
vartype
news@Dictionary
#define DictionaryAliasOff
dcFinalize
dcGetHashCode
dcNull
dcCount
dcGetType
dcGetTableSize
dcForeach
dcKeys
dcValues
dcRefKeys
dcRefValues
dcRefKeysAndValues
dcJoinDict
dcSet
dcAdd
dcReSet
dcItem
dcRefItem
dcTryGetValue
dcRemove
dcClear
dcContainsKey
dcContainsValue
newmod

%group
連想配列の定義
%index
news@Dictionary
連想配列の初期化(配列用)

%prm
dict, type, keySep, itemSep, initDict
dict        : 初期化する連想配列(モジュール型変数で返る)
type="str"  : 型を示す文字列(vartype参照)
keySep=":"  : initDictのキーと値の間の区切り文字
itemSep="," : initDictの要素ごとの区切り文字
initDict    : 連想配列に設定する初期値(文字列)

%inst
連想配列モジュールを初期化し、連想配列のモジュール型変数を生成します。
(Dictionaryモジュールコンストラクタ)

本命令はnew@Dictionaryの配列向け命令であり、配列変数の破棄はされません。

%sample
#include "Dictionary.as"

dimtype dicts, vartype("struct")

repeat 5
	news@Dictionary dicts, "int",,,"2cnt:"+cnt*2
loop

foreach dicts
	mes dcItem(dicts(cnt), "2cnt")
loop
%href
vartype
new@Dictionary
#define DictionaryAliasOff
dcFinalize
dcGetHashCode
dcNull
dcCount
dcGetType
dcGetTableSize
dcForeach
dcKeys
dcValues
dcRefKeys
dcRefValues
dcRefKeysAndValues
dcJoinDict
dcSet
dcAdd
dcReSet
dcItem
dcRefItem
dcTryGetValue
dcRemove
dcClear
dcContainsKey
dcContainsValue
newmod

%group
連想配列の定義

