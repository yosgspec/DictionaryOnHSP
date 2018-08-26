#ifndef Dictionary

;ハッシュ関数(FNV 32bit)
#module @dcGetHashCode
	#defcfunc dcGetHashCode str _s
		s=_s
		#const offset_basis 2166136261
		#const FNV_prime 16777619
		hash=offset_basis
		repeat strlen(s)
			hash=(hash^peek(s,cnt))*FNV_prime
		loop
	return double(strf("%u",hash))
#global

;Dictionaryモジュール
#module Dictionary table,tableSize,tableSize80,keyList,valueList,count,type
	;null
	#define global dcNull "__dcNull__"
	;空文字列エスケープ
	#define nullString "__nullString__"
	#define escNullString(%1,%2) if %2="": %1=nullString: else: %1=%2
	#define usEscNullString(%1,%2) if %2=nullString: %1="": else: %1=%2
	;改行文字
	#const charCr $0D
	#const charLf $0A
	;要素数
	#modcfunc dcCount
		return count
	;辞書型
	#modcfunc dcGetType
		return type
	;ハッシュテーブルサイズ
	#modcfunc dcTableSize
		return tableSize

	;Dictionary用foreachキーワード
	#define global dcForeach(%1) repeat dcCount(%1)
	;インデックスからのキー取得
	#modcfunc dcKeys int _index
		usEscNullString key,keyList(_index)
		return key
	;インデックスからの値取得
	#modcfunc dcValues int _index
		return valueList(_index)
	;キー配列の取得
	#modfunc dcRefKeys array refKeys
		sdim refKeys,,count
		repeat count
			usEscNullString key,keyList(cnt)
			refKeys(cnt)=key
		loop
	return
	;値配列の取得
	#modfunc dcRefValues array refValues
		dimtype refValues,type,count
		repeat count: refValues(cnt)=valueList(cnt): loop
	return
	;キー、値配列の取得
	#modfunc dcRefKeysAndValues array refKeys,array refValues
		sdim refKeys,,count
		dimtype refValues,type,count
		repeat count
			usEscNullString key,keyList(cnt)
			refKeys(cnt)=key
			refValues(cnt)=valueList(cnt)
		loop
	return

	;配列の連結
	#defcfunc local dcJoinArray array ary,str sep
		s=""
		foreach ary
			if 0<cnt: s+=sep
			s+=ary(cnt)
		loop
	return s
	#define global ctype dcJoinArray(%1,%2=",") dcJoinArray@Dictionary(%1,%2)

	;Dictionaryの連結
	#modcfunc local dcJoinDict str keySep,str itemSep
		s=""
		repeat count
			if 0<cnt: s+=itemSep
			s+=dcKeys(thismod,cnt)+keySep+valueList(cnt)
		loop
	return s
	#define global ctype dcJoinDict(%1,%2=":",%3="\\n") dcJoinDict@Dictionary(%1,%2,%3)

	;コンストラクタ
	#define new(%1,%2="str",%3=":",%4=",",%5=dcNull) dimtype %1,5: newmod %1,Dictionary,%2,%3,%4,%5
	#define news(%1,%2="str",%3=":",%4=",",%5=dcNull) newmod %1,Dictionary,%2,%3,%4,%5
	#modinit str _type,str keySep,str itemSep,str _dict
		count=0
		isRehash=0
		tableSize=32

		dict=_dict
		if dcNull!=dict {
			;終端の改行除去
			dict=strtrim(dict,2,charCr)
			dict=strtrim(dict,2,charLf)
			;要素の分割
			split dict,itemSep,dict
			dictLen=length(dict)
			;ハッシュテーブルの拡張
			repeat: if dictLen<tableSize: break: else: tableSize*=2: loop
		}

		type=vartype(""+_type)
		dim table,tableSize
		tableSize80=int(0.8*tableSize)
		sdim keyList,,1
		dimtype valueList,type,1

		if dcNull=dict: return
		;初期値の設定
		sdim dictKey
		sdim dictValue
		foreach dict
			split dict(cnt),keySep,dictKey,dictValue
			dictKey=strtrim(dictKey,3,charCr)
			dictKey=strtrim(dictKey,3,charLf)
			dcSet thismod,dictKey,dictValue
		loop
	return

	;辞書型にキャスト
	#modcfunc local castValue var _value
		if type=2 {return str(_value)}
		else:if type=3 {return double(_value)}
		else:if type=4 {return int(_value)}
	return

	;空のラベル型命令
	*nullFunc:return

	;ハッシュの検索
	#modfunc local __searchHash var notExistFn,var existFn
		hashKey=int(dcGetHashCode(key)\tableSize)
		repeat
			index=table(hashKey)-1
			if index<0 {
				gosub notExistFn
				break
			}
			else:if keyList(index)=key {
				gosub existFn
				break
			}
			hashKey=(hashKey+tableSize-1)\tableSize
		loop
	return
	#define searchHash(%1,%2) %tsearchHash %i=%2:%i=%1:__searchHash thismod,%o,%o

	;キーが存在しない時の処理
	*set_notExist
		index=count
		count++
		table(hashKey)=count
	return

	;値の登録
	#modfunc local dcSet str _key,var _value,int isAdd
		value=castValue(thismod,_value)
		escNullString key,_key
		searchHash *set_notExist,*nullFunc

		keyListLen=length(keyList)
		if keyList(0)="": keyListLen--
		if isAdd & index<keyListLen: return 1
		keyList(index)=key

		if isRehash: return 0

		valueList(index)=value
		if tableSize80<count {
			reHash thismod,tableSize*2
		}
	return 0
	#define global dcSet(%1,%2,%3,%4=0) %tdcSet %i=%3 :dcSet@Dictionary %1,%2,%o,%4
	#define global dcAdd(%1,%2,%3) dcSet %1,%2,%3,1

	;代入演算子
	#modfunc local dcReSet str _key,str sign,var addValue
		if sign="+" | sign="+=" {value=dcItem(thismod,_key)+addValue}
		else:if sign="-" | sign="-=" {value=dcItem(thismod,_key)-addValue}
		else:if sign="*" | sign="*=" {value=dcItem(thismod,_key)*addValue}
		else:if sign="/" | sign="/=" {value=dcItem(thismod,_key)/addValue}
		else:if sign="\\" | sign="\\=" {value=dcItem(thismod,_key)\addValue}
		else:if sign="|" | sign="|=" {value=dcItem(thismod,_key)|addValue}
		else:if sign="&" | sign="&=" {value=dcItem(thismod,_key)&addValue}
		else:if sign="^" | sign="^=" {value=dcItem(thismod,_key)^addValue}
		else:if sign="<<" | sign="<<=" {value=dcItem(thismod,_key)<<addValue}
		else:if sign=">>" | sign=">>=" {value=dcItem(thismod,_key)>>addValue}
		else {return 1}
		dcSet thismod,_key,value,0
	return 0
	#define global dcReSet(%1,%2,%3,%4) %tdcReSet %i=%4 :dcReSet@Dictionary %1,%2,%3,%o

	;キーが存在しない時の処理
	*item_notExist
		value=dcNull
	return

	;キーが存在する時の処理
	*item_exist
		value=valueList(index)
	return

	;値の取得
	#modcfunc dcItem str _key
		escNullString key,_key
		searchHash *item_notExist,*item_exist
	return value

	;値の取得の試行
	#modcfunc dcTryGetValue str _key,var refValue
		value=dcItem(thismod,_key)
		if value=dcNull {
			return 0
		}
		else {
			refValue=value
			return 1
		}

	;キーが存在する時の処理
	*remove_exist
		value=valueList(index)
		count--
		table(hashKey)=0
	return

	;値の削除
	#modfunc dcRemove str _key
		escNullString key,_key
		searchHash *item_notExist,*remove_exist

		if value=dcNull: return 1
		repeat count-index
			i=cnt+index
			keyList(i)=keyList(i+1)
			valueList(i)=valueList(i+1)
		loop
	return 0 

	;辞書のクリア
	#modfunc dcClear
		count=0
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
	#modcfunc dcContainsKey str _key
		isContains=0
		escNullString key,_key
		searchHash *nullFunc,*cKeys_exist
	return isContains

	;値の有無
	#modcfunc dcContainsValue str _value
		isContains=0
		repeat count
			if valueList(cnt)=_value {
				isContains=1
				break
			}
		loop
		return isContains
	return

	;ハッシュの再配置
	#modfunc local reHash int tableSizeNext
		_count=count
		tableSize=tableSizeNext
		tableSize80=int(0.8*tableSize)
		count=0
		isRehash=1
		dim table,tableSize
		repeat _count
			dcSet thismod,keyList(cnt),valueList(cnt)
		loop
		isRehash=0
	return

	;デストラクタ
	#define Finalize(%1) delmod %1
#global
#endif
