#ifndef Dictionary
;公開するAPIのエイリアス
#ifndef DictionaryAliasOff
	#define global dcGetHashCode getHashCode@Dictionary
	#define global dcNull null@Dictionary
	#define global dcCount count@Dictionary
	#define global dcGetType getType@Dictionary
	#define global dcGetTableSize getTableSize@Dictionary
	#define global dcForeach foreach@Dictionary
	#define global dcKeys keys@Dictionary
	#define global dcValues values@Dictionary
	#define global dcRefKeys refKeys@Dictionary
	#define global dcRefValues refValues@Dictionary
	#define global dcRefKeysAndValues refKeysAndValues@Dictionary
	#define global dcJoinArray joinArray@Dictionary
	#define global dcJoinDict joinDict@Dictionary
	#define global dcSet set@Dictionary
	#define global dcAdd add@Dictionary
	#define global dcReSet reSet@Dictionary
	#define global dcItem item@Dictionary
	#define global dcRefItem refItem@Dictionary
	#define global dcTryGetValue tryGetValue@Dictionary
	#define global dcRemove remove@Dictionary
	#define global dcClear clear@Dictionary
	#define global dcContainsKey containsKey@Dictionary
	#define global dcContainsValue containsValue@Dictionary
	#define global dcFinalize finalize@Dictionary
#endif

;Dictionaryモジュール
#module Dictionary table,tableSize,tableSize80,keyList,valueList,thisCount,type
	;ハッシュ関数
	#define getHashCode fnvHash32@@fnvHash32

	;null
	#define null "__$dcNull__"
	#const typeStr 2
	
	;空文字列エスケープ
	#define nullString "__$nullString__"
	#define escNullString(%1,%2) if %1="": %2=nullString: else: %2=%1
	#define unEscNullString(%1,%2) if %1=nullString: %2="": else: %2=%1

	;改行文字
	#const charCr $0D
	#const charLf $0A

	;要素数
	#modcfunc local count
		return thisCount

	;辞書型
	#modcfunc local getType
		return type

	;ハッシュテーブルサイズ
	#modcfunc local getTableSize
		return tableSize

	;Dictionary用foreachキーワード
	#define global foreach@Dictionary(%1) repeat count@Dictionary(%1)

	;インデックスからのキー取得
	#modcfunc local keys int _index
		unEscNullString keyList(_index),key
		return key

	;インデックスからの値取得
	#modcfunc local values int _index
		return valueList(_index)

	;キー配列の取得
	#modfunc local refKeys array refKeyList
		sdim refKeyList,,thisCount
		repeat thisCount
			unEscNullString keyList(cnt),key
			refKeyList(cnt)=key
		loop
	return

	;値配列の取得
	#modfunc local refValues array refValueList
		dimtype refValueList,type,thisCount
		repeat thisCount: refValueList(cnt)=valueList(cnt): loop
	return

	;キー、値配列の取得
	#modfunc local refKeysAndValues array refKeyList,array refValueList
		sdim refKeyList,,thisCount
		dimtype refValueList,type,thisCount
		repeat thisCount
			unEscNullString keyList(cnt),key
			refKeyList(cnt)=key
			refValueList(cnt)=valueList(cnt)
		loop
	return

	;配列の連結
	#define ctype joinArray(%1,%2=",") __joinArray@Dictionary(%1,%2)
	#defcfunc local __joinArray array ary,str sep
		s=""
		foreach ary
			if 0<cnt: s+=sep
			s+=ary(cnt)
		loop
	return s

	;Dictionaryの連結
	#define ctype joinDict(%1,%2=":",%3="\\n") __joinDict@Dictionary(%1,%2,%3)
	#modcfunc local __joinDict str keySep,str itemSep
		s=""
		repeat thisCount
			if 0<cnt: s+=itemSep
			s+=keys(thismod,cnt)+keySep+valueList(cnt)
		loop
	return s

	;コンストラクタ
	#define new(%1,%2="str",%3=":",%4=",",%5=null@Dictionary) %tDictionary dimtype %1,5: newmod %1,Dictionary,%2,%3,%4,%5
	#define news(%1,%2="str",%3=":",%4=",",%5=null@Dictionary) newmod %1,Dictionary,%2,%3,%4,%5
	#modinit str _type,str keySep,str itemSep,str _dict
		thisCount=0
		isRehash=0
		tableSize=32

		dict=_dict
		dictLen=0
		if dict!=null {
			;終端の改行除去
			dict=strtrim(dict,2,charLf)
			dict=strtrim(dict,2,charCr)
			;要素の分割
			split dict,itemSep,dict
			dictLen=length(dict)
			;ハッシュテーブルの拡張
			repeat: if dictLen<tableSize: break: else: tableSize*=2: loop
		}

		type=vartype(""+_type)
		dim table,tableSize
		tableSize80=int(0.8*tableSize)
		sdim keyList,,dictLen
		dimtype valueList,type,dictLen

		if dict=null: return
		;初期値の設定
		sdim dictKey
		sdim dictValue
		foreach dict
			split dict(cnt),keySep,dictKey,dictValue
			dictKey=strtrim(dictKey,3,charCr)
			dictKey=strtrim(dictKey,3,charLf)
			__set thismod,dictKey,dictValue,0
		loop
	return

	;辞書型にキャスト
	#define castValue(%1,%2) \
		if type=2 {%2=str(%1)} \
		else:if type=3 {%2=double(%1)} \
		else:if type=4 {%2=int(%1)} \
		else:if type=vartype(%1) {%2=%1} \
		else {%2=null@Dictionary}

	;空のラベル型命令
	*nullFunc:return

	;ハッシュの検索
	#modfunc local __searchHash str _key,var notExistFn,var existFn
		hashKey=int(getHashCode(_key)\tableSize)
		repeat
			index=table(hashKey)-1
			if index<0 {
				gosub notExistFn
				break
			}
			else:if keyList(index)=_key {
				gosub existFn
				break
			}
			hashKey=(hashKey+tableSize-1)\tableSize
		loop
	return
	#define searchHash(%1,%2,%3) %tsearchHash %i=%3:%i=%2:__searchHash thismod,%1,%o,%o

	;キーが存在しない時の処理
	*set_notExist
		index=thisCount
		thisCount++
		table(hashKey)=thisCount
	return

	;値の登録
	#define set(%1,%2,%3,%4=0) %tdcSet %i=%3 :__set@Dictionary %1,%2,%o,%4
	#modfunc local __set str _key,var _value,int isAdd
		castValue _value,value
		if vartype(value)=typeStr: if value=null: return 2
		escNullString _key,key
		searchHash key,*set_notExist,*nullFunc

		keyListLen=length(keyList)
		if keyList(0)="": keyListLen--
		if isAdd & index<keyListLen: return 1
		keyList(index)=key

		if isRehash: return 0

		valueList(index)=value
		if tableSize80<thisCount {
			reHash thismod,tableSize*2
		}
	return 0

	;値の追加
	#define add(%1,%2,%3) set@Dictionary %1,%2,%3,1

	;代入演算子
	#define reSet(%1,%2,%3,%4) %tdcReSet %i=%4 :__ReSet@Dictionary %1,%2,%3,%o
	#modfunc local __reSet str _key,str sign,var addValue
		#define reSetSign(%1) \
			escNullString _key,key :\
			searchHash key,*nullFunc,*nullFunc :\
			if 0<=index {valueList(index)=valueList(index)%1addValue}\
			else {return 1}
		if sign="+" | sign="+=" {reSetSign +}
		else:if sign="-" | sign="-=" {reSetSign -}
		else:if sign="*" | sign="*=" {reSetSign *}
		else:if sign="/" | sign="/=" {reSetSign /}
		else:if sign="\\" | sign="\\=" {reSetSign \}
		else:if sign="|" | sign="|=" {reSetSign |}
		else:if sign="&" | sign="&=" {reSetSign &}
		else:if sign="^" | sign="^=" {reSetSign ^}
		else:if sign="<<" | sign="<<=" {reSetSign <<}
		else:if sign=">>" | sign=">>=" {reSetSign >>}
		else {return 1}
	return 0

	;キーが存在しない時の処理
	*item_notExist
		value=null
	return

	;キーが存在する時の処理
	*item_exist
		value=valueList(index)
	return

	;値の取得
	#modcfunc local item str _key
		escNullString _key,key
		searchHash key,*item_notExist,*item_exist
	return value
	#modfunc local refItem str _key,var refValue
		escNullString _key,key
		searchHash key,*item_notExist,*item_exist
		refValue=value
	return

	;値の取得の試行
	#modcfunc local tryGetValue str _key,var refValue
		refItem thismod,_key,value
		if vartype(value)=typeStr: if value=null {
			return 0
		}
		else {
			refValue=value
			return 1
		}

	;キーが存在する時の処理
	*remove_exist
		value=valueList(index)
		thisCount--
		table(hashKey)=0
	return

	;値の削除
	#modfunc local remove str _key
		escNullString _key,key
		searchHash key,*item_notExist,*remove_exist

		if vartype(value)=typeStr: if value=null: return 1
		repeat thisCount-index
			i=cnt+index
			keyList(i)=keyList(i+1)
			valueList(i)=valueList(i+1)
		loop
	return 0 

	;辞書のクリア
	#modfunc local clear
		thisCount=0
		isRehash=0
		tableSize=32
		dim table,tableSize
		tableSize80=int(0.8*tableSize)
		sdim keyList,,1
		dimtype valueList,type,1
	return

	;キーが存在する時の処理
	*cKeys_exist
		isContains=1
	return

	;キーの有無
	#modcfunc local containsKey str _key
		isContains=0
		escNullString _key,key
		searchHash key,*nullFunc,*cKeys_exist
	return isContains

	;値の有無
	#modcfunc local containsValue str _value
		isContains=0
		repeat thisCount
			if valueList(cnt)=_value {
				isContains=1
				break
			}
		loop
		return isContains
	return

	;ハッシュの再配置
	#modfunc local reHash int tableSizeNext
		_itemCount=thisCount
		tableSize=tableSizeNext
		tableSize80=int(0.8*tableSize)
		thisCount=0
		isRehash=1
		dim table,tableSize
		repeat _itemCount
			set thismod,keyList(cnt),valueList(cnt)
		loop
		isRehash=0
	return

	;デストラクタ
	#define finalize(%1) delmod %1
#global

;ハッシュ関数(FNV 32bit)
#module @fnvHash32
	#defcfunc local fnvHash32 str _s
		s=_s
		#const offset_basis 2166136261
		#const FNV_prime 16777619
		hash=offset_basis
		repeat strlen(s)
			hash=(hash^peek(s,cnt))*FNV_prime
		loop
	return double(strf("%u",hash))
#global
#endif
