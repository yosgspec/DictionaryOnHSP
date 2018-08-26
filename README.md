# Dictionary On HSP APIs
* new@Dictionary struct dict[, str type="str", str keySep=":", itemSep=",", str initDict]  
* news@Dictionary struct dict[, str type="str", str keySep=":", itemSep=",", str initDict]  
dict=Dictionaryオブジェクト  
type=型を示す文字列  
keySep=initDictのキーと値の間の区切り文字  
itemSep=initDictの要素ごとの区切り文字  
initDict=Dictionaryに設定する初期値  
　  
Dictionaryオブジェクトを生成します。  
newでは初期化する変数を自動で生成します。  
配列などにDictionaryを格納する場合はnewsまたはnewmodをご利用ください。

* str dcNull  
Dictionaryモジュールで空と見なす定数です。  

* double hashCode=dcGetHashCode(str s)  
s=ハッシュ化する文字列  
Dictionaryモジュールで使用するハッシュ関数する。  

* int count=dcCount()  
登録されている要素数を返します。  

* int tableSize=dcTableSize(struct dict)  
ハッシュテーブルのサイズを取得します。  
ハッシュテーブルのサイズは必要に応じて自動で拡張されます。  

* dcForeach(struct dict)  
repeat/foreachキーワードの代わりに使用します。  
要素のインデックスを順番に取得します。  

* str key=dcKeys(struct dict, int index)  
index=オブジェクトに登録される要素のインデックス値  
インデックスに登録されているキーを取得します。

* val value=dcValues(struct dict, int index)  
インデックスに登録されている値を取得します。  

* dcRefKeys struct dict, ref array keys  
keys=キーの配列を返す変数。  
登録されているキーの配列を取得します。【未実装】  

* dcRefValues struct dict, ref array values  
valuess=キーの配列を返す変数。  
登録されている値の配列を取得します。【未実装】  

* int type=dcGetType(struct dict)  
登録した型を返します。  

* dcSet struct dict, str key, val value  
key=登録するキー
value=登録する値
キーに値をセットします。  

* dcAdd struct dict, str key, val value  
dcSetと同様ですが、重複される値は登録されません。  
登録できなかった場合はstatに1が返ります。

* dcReSet struct dict, str key, str sign, val addValue  
key=再代入する要素のキー  
sign=演算子の文字列(+-*/\|&<<>>)  
addValue=演算子を適用する値  
　  
代入演算子に相当する命令です。  
signに設定した演算子と値を適用して再代入します。  

* val value=dcItem(struct dict, str key)  
key=要素のキー  
value=取得した値  
　  
要素を取得します。

* int isSuccess=TryGetValue(struct dict, str key, var refValue)  
要素を取得できるか試します。
取得できた場合は1を返し、refValueに値を返します。  
できなかった場合は0を返します。【未実装】  

* dcRemove struct dict, str _key  
要素を削除します。【未実装】  

* dcClear struct dict  
登録される要素を全て削除します。【未実装】  

* int isContains=dcContainsKey(struct dict, str _key)  
キーが存在するか確かめます。【未実装】  

* int isContains=dcContainsValue(struct dict, str _value)  
値が存在するか確かめます。【未実装】  

* finalize@Dictionary struct dict  
オブジェクトを解放します。  
delmodと同一です。
