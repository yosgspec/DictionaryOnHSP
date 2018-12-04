;--------------------------------------------------
; HSP ヘルプ ソースファイル (hs 形式)
; hs ファイルの書式については、HS_BIBLE.txt を参照してください。

;--------------------------------------------------
; この hs ファイルのデフォルトのフィールド値を設定

%dll
Dictionary

%ver
3.5

%date
2019/1/1

%author
YOS G-spec

%url
https://github.com/yosgspec/DictionaryOnHSP

%note
連想配列モジュール
Dictionary.asをインクルードすること。

%type
ユーザー定義命令

%port
Win
Mac
Cli
HSP3Dish

%portinfo
; 移植のヒント を記入

%index
new@Dictionary
連想配列を初期化

%prm
dict, type, keySep, itemSep, initDict
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の定義
%index
news@Dictionary
連想配列を初期化(配列)

%prm
dict, type, keySep, itemSep, initDict
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の定義

%index
dcNull
連想配列で空を示す定数

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcGetHashCode
連想配列のハッシュ関数

%prm
(s)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の状態
%index
dcCount
連想配列の要素数

%prm
(dict)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の状態

%index
dcGetTableSize
ハッシュテーブルのサイズを取得

%prm
(dict)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の状態

%index
dcForeach
連想配列の要素数だけ繰り返す

%prm
dict
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcKeys
連想配列の添字からキーを取得

%prm
(dict, index)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用
%index
dcValues
連想配列の添字から値を取得

%prm
(dict, index)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcRefKeys
連想配列からキーの配列を取得

%prm
dict, refKeys
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用
%index
dcRefValues
連想配列から値の配列を取得

%prm
dict, refValues
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcRefKeysAndValues
連想配列からキーと値の配列を取得

%prm
dict, refKeys, refValues  
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcJoinArray
配列を結合

%prm
(ary, sep)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcJoinDict
連想配列を結合

%prm
(dict, keySep, itemSep)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の活用

%index
dcGetType
連想配列の型を取得

%prm
(dict)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の状態

%index
dcSet
連想配列の要素に値を代入

%prm
dict, key, value
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の操作

%index
dcAdd
連想配列に要素を追加

%prm
dict, key, value
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の操作
%index
dcReSet
連想配列の要素に演算を適用して再代入

%prm
dict, key, sign, addValue 
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の操作

%index
dcItem
連想配列から要素を取得

%prm
(dict, key)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の要素
%index
dcRefItem
連想配列から要素を取得(参照渡し)

%prm
(dict, key, refValue)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の要素

%index
dcTryGetValue
連想配列から要素の取得を試す

%prm
(dict, key, refValue)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の要素

%index
dcRemove
連想配列から要素を削除

%prm
dict, key
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の操作

%index
dcClear
連想配列から全ての要素を削除

%prm
dict
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の操作

%index
dcContainsKey
連想配列にキーが存在するか確かめる

%prm
(dict, key)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の状態

%index
dcContainsValue
連想配列に値が存在するか確かめる

%prm
(dict, value)
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の状態

%index
dcFinalize
連想配列を削除

%prm
dict
; パラメータ説明文 を記入

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の定義

%index
#define DictionaryAliasOff
連想配列モジュールのエイリアスを無効化

%inst
; 解説文 を記入

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
連想配列の定義

