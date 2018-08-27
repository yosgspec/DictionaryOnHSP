#ifndef Dictionary

;�n�b�V���֐�(FNV 32bit)
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

;Dictionary���W���[��
#module Dictionary table,tableSize,tableSize80,keyList,valueList,count,type
	;null
	#define global dcNull "__$dcNull__"
	;�󕶎���G�X�P�[�v
	#define nullString "__$nullString__"
	#define escNullString(%1,%2) if %1="": %2=nullString: else: %2=%1
	#define unEscNullString(%1,%2) if %1=nullString: %2="": else: %2=%1
	;���s����
	#const charCr $0D
	#const charLf $0A
	;�v�f��
	#modcfunc dcCount
		return count
	;�����^
	#modcfunc dcGetType
		return type
	;�n�b�V���e�[�u���T�C�Y
	#modcfunc dcTableSize
		return tableSize

	;Dictionary�pforeach�L�[���[�h
	#define global dcForeach(%1) repeat dcCount(%1)
	;�C���f�b�N�X����̃L�[�擾
	#modcfunc dcKeys int _index
		unEscNullString keyList(_index),key
		return key
	;�C���f�b�N�X����̒l�擾
	#modcfunc dcValues int _index
		return valueList(_index)
	;�L�[�z��̎擾
	#modfunc dcRefKeys array refKeys
		sdim refKeys,,count
		repeat count
			unEscNullString keyList(cnt),key
			refKeys(cnt)=key
		loop
	return
	;�l�z��̎擾
	#modfunc dcRefValues array refValues
		dimtype refValues,type,count
		repeat count: refValues(cnt)=valueList(cnt): loop
	return
	;�L�[�A�l�z��̎擾
	#modfunc dcRefKeysAndValues array refKeys,array refValues
		sdim refKeys,,count
		dimtype refValues,type,count
		repeat count
			unEscNullString keyList(cnt),key
			refKeys(cnt)=key
			refValues(cnt)=valueList(cnt)
		loop
	return

	;�z��̘A��
	#defcfunc local dcJoinArray array ary,str sep
		s=""
		foreach ary
			if 0<cnt: s+=sep
			s+=ary(cnt)
		loop
	return s
	#define global ctype dcJoinArray(%1,%2=",") dcJoinArray@Dictionary(%1,%2)

	;Dictionary�̘A��
	#modcfunc local dcJoinDict str keySep,str itemSep
		s=""
		repeat count
			if 0<cnt: s+=itemSep
			s+=dcKeys(thismod,cnt)+keySep+valueList(cnt)
		loop
	return s
	#define global ctype dcJoinDict(%1,%2=":",%3="\\n") dcJoinDict@Dictionary(%1,%2,%3)

	;�R���X�g���N�^
	#define new(%1,%2="str",%3=":",%4=",",%5=dcNull) %tDictionary dimtype %1,5: newmod %1,Dictionary,%2,%3,%4,%5
	#define news(%1,%2="str",%3=":",%4=",",%5=dcNull) newmod %1,Dictionary,%2,%3,%4,%5
	#modinit str _type,str keySep,str itemSep,str _dict
		count=0
		isRehash=0
		tableSize=32

		dict=_dict
		dictLen=0
		if dcNull!=dict {
			;�I�[�̉��s����
			dict=strtrim(dict,2,charLf)
			dict=strtrim(dict,2,charCr)
			;�v�f�̕���
			split dict,itemSep,dict
			dictLen=length(dict)
			;�n�b�V���e�[�u���̊g��
			repeat: if dictLen<tableSize: break: else: tableSize*=2: loop
		}

		type=vartype(""+_type)
		dim table,tableSize
		tableSize80=int(0.8*tableSize)
		sdim keyList,,dictLen
		dimtype valueList,type,dictLen

		if dcNull=dict: return
		;�����l�̐ݒ�
		sdim dictKey
		sdim dictValue
		foreach dict
			split dict(cnt),keySep,dictKey,dictValue
			dictKey=strtrim(dictKey,3,charCr)
			dictKey=strtrim(dictKey,3,charLf)
			dcSet thismod,dictKey,dictValue
		loop
	return

	;�����^�ɃL���X�g
	#define castValue(%1,%2) \
		if type=2 {%2=str(%1)} \
		else:if type=3 {%2=double(%1)} \
		else:if type=4 {%2=int(%1)} \
		else:if type=vartype(%1) {%2=%1} \
		else {%2=dcNull}

	;��̃��x���^����
	*nullFunc:return

	;�n�b�V���̌���
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

	;�L�[�����݂��Ȃ����̏���
	*set_notExist
		index=count
		count++
		table(hashKey)=count
	return

	;�l�̓o�^
	#modfunc local dcSet str _key,var _value,int isAdd
		dimtype value,type
		castValue _value,value
		if vartype(value)="str": if value=dcNull: return 2
		escNullString _key,key
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

	;������Z�q
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

	;�L�[�����݂��Ȃ����̏���
	*item_notExist
		value=dcNull
	return

	;�L�[�����݂��鎞�̏���
	*item_exist
		value=valueList(index)
	return

	;�l�̎擾
	#modcfunc dcItem str _key
		escNullString _key,key
		searchHash *item_notExist,*item_exist
	return value
	#modfunc dcRefItem str _key,var refValue
		escNullString _key,key
		searchHash *item_notExist,*item_exist
		refValue=value
	return

	;�l�̎擾�̎��s
	#modcfunc dcTryGetValue str _key,var refValue
		dcRefItem thismod,_key,value
		if vartype(value)="str": if value=dcNull {
			return 0
		}
		else {
			refValue=value
			return 1
		}

	;�L�[�����݂��鎞�̏���
	*remove_exist
		value=valueList(index)
		count--
		table(hashKey)=0
	return

	;�l�̍폜
	#modfunc dcRemove str _key
		escNullString _key,key
		searchHash *item_notExist,*remove_exist

		if vartype(value)="str": if value=dcNull: return 1
		repeat count-index
			i=cnt+index
			keyList(i)=keyList(i+1)
			valueList(i)=valueList(i+1)
		loop
	return 0 

	;�����̃N���A
	#modfunc dcClear
		count=0
		isRehash=0
		tableSize=32
		dim table,tableSize
		tableSize80=int(0.8*tableSize)
		sdim keyList,,1
		dimtype valueList,type,1
	return

	;�L�[�����݂��鎞�̏���
	*cKeys_exist
		isContains=1
	return

	;�L�[�̗L��
	#modcfunc dcContainsKey str _key
		isContains=0
		escNullString _key,key
		searchHash *nullFunc,*cKeys_exist
	return isContains

	;�l�̗L��
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

	;�n�b�V���̍Ĕz�u
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

	;�f�X�g���N�^
	#define Finalize(%1) delmod %1
#global
#endif
