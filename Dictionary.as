#ifndef Dictionary
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

#module Dictionary table,tableSize,tableSize80,keyList,valueList,count,type
	#define global dcNull "__dcNull__"
	#define dcNullString "__dcNullString__"
	#const dcCr $0D
	#const dcLf $0A

	#modcfunc dcCount
		return count
	#define global dcForeach(%1) repeat dcCount(%1)
	#define dcTableSize
		return tableSize
	#modcfunc dcKeys int _index
		key=keyList(_index)
		if key=dcNullString {return ""}
		else {return keyList(_index)}
	#modcfunc dcValues int _index
		return valueList(_index)
	#modfunc dcRefKeys array keys
	#modfunc dcRefValues array values
	#modcfunc dcGetType
		return type

	#define new(%1,%2="str",%3=dcNull) dimtype %1,5: newmod %1,Dictionary,%2,%3
	#define news(%1,%2="str",%3=dcNull) newmod %1,Dictionary,%2,%3
	#modinit str _T,str _dict
		count=0
		isRehash=0
		tableSize=32

		dict=_dict
		if dcNull!=dict {
			split dict,",",dict
			lenDict=length(dict)
			repeat: if lenDict<tableSize: break: else: tableSize*=2: loop
		}

		type=vartype(""+_T)
		dim table,tableSize
		tableSize80=int(0.8*tableSize)
		sdim keyList,,1
		dimtype valueList,type,1

		if dcNull=dict: return

		sdim dictKey
		sdim dictValue
		foreach dict
			split dict(cnt),":",dictKey,dictValue
			dictKey=strtrim(dictKey,3,dcCr)
			dictKey=strtrim(dictKey,3,dcLf)
			dcSet thismod,dictKey,dictValue
		loop
	return

	#modcfunc local castValue var _value
		if type=2 {return str(_value)}
		else:if type=3 {return double(_value)}
		else:if type=4 {return int(_value)}
	return

	#define setNullKey(%1,%2) if %1="": %2=dcNullString: else: %2=%1

	#modfunc local dcSet str _key,var _value,int isAdd
		_value=castValue(thismod,_value)
		setNullKey _key,key
		hashKey=int(dcGetHashCode(key)\tableSize)
		repeat
			index=table(hashKey)-1
			if index<0 {
				index=count
				count++
				table(hashKey)=count
				break
			}
			else:if keyList(index)=key: break
			hashKey=(hashKey+tableSize-1)\tableSize
		loop

		if isAdd & index<length(keyList) {
			return 1
		}
		keyList(index)=key

		if isRehash: return 0

		valueList(index)=_value
		if tableSize80<count {
			reHash thismod,tableSize*2
		}
	return 0
	#define global dcSet(%1,%2,%3,%4=0) %tdcSet %i=%3 :dcSet@Dictionary %1,%2,%o,%4
	#define global dcAdd(%1,%2,%3,%4=1) dcSet %1,%2,%3,%4

	#modfunc local dcReSet str _key,str assign,var addValue
		if assign="+" | assign="+=" {value=dcItem(thismod,_key)+addValue}
		else:if assign="-" | assign="-=" {value=dcItem(thismod,_key)-addValue}
		else:if assign="*" | assign="*=" {value=dcItem(thismod,_key)*addValue}
		else:if assign="/" | assign="/=" {value=dcItem(thismod,_key)/addValue}
		else:if assign="\\" | assign="\\=" {value=dcItem(thismod,_key)\addValue}
		else:if assign="|" | assign="|=" {value=dcItem(thismod,_key)|addValue}
		else:if assign="&" | assign="&=" {value=dcItem(thismod,_key)&addValue}
		else:if assign="^" | assign="^=" {value=dcItem(thismod,_key)^addValue}
		else:if assign="<<" | assign="<<=" {value=dcItem(thismod,_key)<<addValue}
		else:if assign=">>" | assign=">>=" {value=dcItem(thismod,_key)>>addValue}
		else {mes "Error"}
		dcSet thismod,_key,value,0
	return
	#define global dcReSet(%1,%2,%3,%4) %tdcReSet %i=%4 :dcReSet@Dictionary %1,%2,%3,%o

	#modcfunc dcItem str _key
		setNullKey _key,key
		hashKey=int(dcGetHashCode(key)\tableSize)

		repeat
			index=table(hashKey)-1
			if index<0 {
				value=dcNull
				break
			}
			else:if keyList(index)=key{
				value=valueList(index)
				break
			}
			hashKey=(hashKey+tableSize-1)\tableSize
		loop
	return value

	#modcfunc TryGetValue str _key,var refValue
	#modfunc dcRemove str _key
	#modfunc dcClear
	#modcfunc dcContainsKey str _key
	#modcfunc dcContainsValue str _value

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

	#define Finalize(%1) delmod %1
#global
#endif
