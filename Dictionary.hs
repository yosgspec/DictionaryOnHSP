;--------------------------------------------------
; �y�A�z�z��zDictionary���W���[��
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
�A�z�z�񃂃W���[��
Dictionary.as���C���N���[�h���邱�ƁB

%type
���[�U�[��`����/�֐�

%port
Win
Mac
Cli
HSP3Dish
%index
#define DictionaryAliasOff
�A�z�z�񃂃W���[���̃G�C���A�X�𖳌���

%inst
�A�z�z�񃂃W���[���̃C���N���[�h�O�ɐ錾�����dc����n�܂��`��S�Ė��������܂��B
���̏ꍇ���̑Ή��ɏ]���Ė���/�֐����Ăяo���K�v������܂��B

�G�C���A�X         : ���ۂ̖���/�֐���
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
	hobby:�Ǐ�,
	work:���Ј�
"}

// mes dcItem(dict, "name") // ������
mes item@Dictionary(dict, "name")


// �G�C���A�X���ǂ�
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
�A�z�z��̒�`
%index
dcAdd
�A�z�z��ɗv�f��ǉ�

%prm
dict, key, value
dict  : �A�z�z��̃��W���[���^�ϐ�
key   : �o�^����L�[(������)
value : �o�^����l
        (�^�͘A�z�z��̌^(dcGetType)�œo�^����邪�A
         ������A���V�����_�A������Ԃ͊e���ϊ������)

%inst
�A�z�z��̃L�[�ɒl���Z�b�g���܂��B
dcSet�Ƃ͈قȂ�A�d�������l�͓o�^����܂���B
���x���^�A���W���[���^�̏ꍇ�͌^���قȂ�Ǝ��s���܂��B

�����̌��ʂ�stat�ɑ������A���L�̂悤�ɂȂ�܂��B

stat : ���
-----:----------------------------------------------
 0   : ����ɏ�������������
 1   : �L�[�����ɓo�^����Ă��邽�߁A�����Ɏ��s����
 2   : �^���قȂ邽�ߏ����Ɏ��s����
     : (���x���^�A���W���[���^�̂�)


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����add@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict
dcAdd dict, "name", "bob"
if stat: mes {"���ɃL�["name"�͑��݂��Ă��܂��B"}
mes dcItem(dict, "name")

dcAdd dict, "name", "taro"
if stat: mes {"���ɃL�["name"�͑��݂��Ă��܂��B"}
mes dcItem(dict, "name")


new@Dictionary ldict, "label"
ldim item, 0
dcAdd ldict, "name", *ken
if stat = 2 {
	mes "�^���Ⴂ�܂��B"
}
else {
	dcRefItem ldict, "name", item
	gosub item
}

dcAdd ldict, "name", "taro"
if stat = 2 {
	mes "�^���Ⴂ�܂��B"
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
�v�f�̕ύX
%index
dcClear
�A�z�z�񂩂�S�Ă̗v�f���폜

%prm
dict
dict : �A�z�z��̃��W���[���^�ϐ�

%inst
�A�z�z��ɓo�^�����v�f��S�č폜���܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����clear@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

mes "�ydcClear�O�z"
mes dcJoinDict(dict)

dcClear dict

mes "�ydcClear��z"
mes dcJoinDict(dict)

%href
dcRemove
dcFinalize
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
�v�f�̕ύX
%index
dcContainsKey
�A�z�z��ɃL�[�����݂��邩�m���߂�

%prm
(dict, key)
val=0,1 : �L�[�̑��݂̉�(0=���s,1=����)
dict    : �A�z�z��̃��W���[���^�ϐ�
key     : ���݂��m�F����L�[(������)

%inst
�A�z�z��ɃL�[�����݂��邩�m���߂܂��B

�A�z�z��ɃL�[�����݂��Ă���ꍇ��1��Ԃ��A 
���݂��Ă��Ȃ��ꍇ��0��Ԃ��܂��B 


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����containsKey@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

if dcContainsKey(dict, "name") {
	mes "�L�[�͑��݂��܂��B"
}
else {
	mes "�L�[�͑��݂��܂���B"
}

if dcContainsKey(dict, "hsp") {
	mes "�L�[�͑��݂��܂��B"
}
else {
	mes "�L�[�͑��݂��܂���B"
}


%href
dcAdd
dcTryGetValue
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
��Ԃ̎擾
%index
dcContainsValue
�A�z�z��ɒl�����݂��邩�m���߂�

%prm
(dict, value)
val=0,1 : �L�[�̑��݂̉�(0=���s,1=����)
dict    : �A�z�z��̃��W���[���^�ϐ�
value   : ���݂��m�F����l
          (������܂��͕�����ɕϊ����������A���V�����_)

%inst
�l�����݂��邩�m���߂܂�(���`�T��)�B
�����A���V�����_�̒l��T���ꍇ�ł�������ɕϊ����ė^���Ă��������B

�A�z�z��ɒl�����݂��Ă���ꍇ��1��Ԃ��A 
���݂��Ă��Ȃ��ꍇ��0��Ԃ��܂��B 


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����containsValue@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

if dcContainsValue(dict, "bob") {
	mes "�l�͑��݂��܂��B"
}
else {
	mes "�l�͑��݂��܂���B"
}

if dcContainsValue(dict, "taro") {
	mes "�l�͑��݂��܂��B"
}
else {
	mes "�l�͑��݂��܂���B"
}

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
��Ԃ̎擾
%index
dcCount
�A�z�z��̗v�f��

%prm
(dict)
val  : �A�z�z��̗v�f��(����)
dict : �A�z�z��̃��W���[���^�ϐ�

%inst
�A�z�z��ɓo�^����Ă���v�f����Ԃ��܂��B 


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����count@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

mes dcCount(dict)

%href
repeat
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
��Ԃ̎擾
%index
dcFinalize
�A�z�z��̏���

%prm
dict
dict : �A�z�z��̃��W���[���^�ϐ�

%inst
�A�z�z��̃��W���[���^�ϐ����폜���܂��B
delmod�Ɠ���ł��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����finalize@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"name:bob"}

mes dcItem(dict, "name")

dcFinalize dict

// mes dcItem(dict, "name")
// #Error 36 in line 170 (Dictionary.as)
// -->���W���[���ϐ��̎w�肪�����ł�

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff
delmod

%group
�A�z�z��̒�`

%index
dcForeach
�A�z�z��̗v�f�������J��Ԃ�

%prm
dict
dict : �A�z�z��̃��W���[���^�ϐ�

%inst
repeat/foreach�L�[���[�h�̑���Ɏg�p���܂��B
�z��ϐ��Ɋi�[����Ă���v�f�̐������J��Ԃ����s�Ȃ��܂��B
�v�f�̃C���f�b�N�X�����ԂɎ擾���܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����foreach@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
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
���[�e�B���e�B
%index
dcGetHashCode
�A�z�z��̃n�b�V���֐�

%prm
(hashStr)
val=0�` : ����ꂽ�n�b�V���l(����)
hashStr : �n�b�V�������镶����

%inst
�A�z�z��Ŏg�p����n�b�V���֐��ł��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����getHashCode@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

mes dcGetHashCode("����������")

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
���[�e�B���e�B
%index
dcGetTableSize
�n�b�V���e�[�u���̃T�C�Y

%prm
(dict)
val=32�` : �n�b�V���e�[�u���̃T�C�Y(����)
dict     : �A�z�z��̃��W���[���^�ϐ�

%inst
�A�z�z��Ɏg����n�b�V���e�[�u���̃T�C�Y���擾���܂��B  
�n�b�V���e�[�u���̃T�C�Y�͕K�v�ɉ����Ď����Ŋg������܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����getTableSize@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
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
��Ԃ̎擾
%index
dcGetType
�A�z�z��̌^

%prm
(dict)
val=1�`6 : �A�z�z��̌^����������(vartype�Q��)
dict     : �A�z�z��̃��W���[���^�ϐ�

%inst
�A�z�z��ɓo�^���Ă���^��Ԃ��܂��B
�^�̓��W���[���^�ϐ��̏��������̂ݎw��ł��܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����getType@Dictionary���g�p���܂��B

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
	if v = 1: mes "���x���^"
	if v = 2: mes "������^"
	if v = 3: mes "�����^"
	if v = 4: mes "�����^"
	if v = 5: mes "���W���[���^"
	if v = 6: mes "COM�I�u�W�F�N�g�^"
loop

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
��Ԃ̎擾

%index
dcItem
�A�z�z�񂩂�v�f���擾

%prm
(dict, key)
val  : �擾�����l(�����A���V�����_�A������)
dict : �A�z�z��̃��W���[���^�ϐ�
key  : �擾����v�f�̃L�[

%inst
�A�z�z�񂩂�v�f���擾���܂��B
������Ȃ������ꍇ��dcNull���Ԃ�܂��B

���x���^�⃂�W���[���^�̒l�擾�������ꍇ�́A�Q�ƕԂ��ł�dcRefItem���g�p���Ă��������B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����item@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
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
�v�f�̎擾
%index
dcJoinArray
�z��̌���

%prm
(ary, sep)
val : �z�����������������
ary : ��������z��ϐ�  
sep : ��؂蕶����  

%inst
�z�����؂蕶���Ō������ĕ������Ԃ��܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����joinArray@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

ary = "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"

mes dcJoinArray(ary)

%href
#define DictionaryAliasOff

%group
���[�e�B���e�B
%index
dcJoinDict
�A�z�z��̌���

%prm
(dict, keySep, itemSep)
val     : �A�z�z�����������������
dict    : �A�z�z��̃��W���[���^�ϐ�
keySep  : �L�[�ƒl�̊Ԃ̋�؂蕶����
itemSep : �v�f���Ƃ̋�؂蕶����

%inst
�A�z�z�����؂蕶���Ō������ĕ������Ԃ��܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����joinDict@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

mes dcJoinDict(dict)

%href
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
���[�e�B���e�B
%index
dcKeys
�A�z�z��̃C���f�b�N�X����L�[���擾

%prm
(dict, index)
val   : �擾�����L�[(������)
dict  : �A�z�z��̃��W���[���^�ϐ�
index : �A�z�z��ɓo�^�����v�f�̃C���f�b�N�X

%inst
�A�z�z��̃C���f�b�N�X�ɓo�^����Ă���L�[���擾���܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����keys@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
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
�v�f�̎擾
%index
dcNull
�A�z�z��ŋ�������萔

%inst
�A�z�z�񃂃W���[���ɂċ�������萔�ł��B
dcItem�ɂėv�f��������Ȃ������Ƃ��ɖ{�l���Ԃ�܂��B

�Ȃ��AdcNull�̒l��"__$dcNull__"�ƒ�`����Ă��܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�萔�͎g�p�ł��Ȃ��Ȃ�A�����null@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict

mes dcNull
mes dcItem(dict, "�Ȃ���")
mes dcNull = dcItem(dict, "�Ȃ���")

%href
dcItem
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
���[�e�B���e�B

%index
dcRefItem
�A�z�z�񂩂�v�f���擾(�Q�Ɠn��)

%prm
dict, key, refValue
dict     : �A�z�z��̃��W���[���^�ϐ�
key      : �v�f�̃L�[
refValue : �l��Ԃ��ϐ�
           (�^��dcGetType�œ�������̂ɓ�����)

%inst
dcItem�̎Q�Ɠn���łł��B
�A�z�z�񂩂�v�f���擾���܂��B
������Ȃ������ꍇ��dcNull���Ԃ�܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refItem@Dictionary���g�p���܂��B

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
*hobby: mes "�Ǐ�": return
*work: mes "���Ј�": return

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
�v�f�̎擾

%index
dcRefKeys
�A�z�z�񂩂�L�[�̔z����擾

%prm
dict, refKeys
dict    : �A�z�z��̃��W���[���^�ϐ�
refKeys : �L�[�̔z���Ԃ�������z��ϐ�

%inst
�A�z�z�񂩂�o�^����Ă���L�[�̔z����擾���܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refKeys@Dictionary���g�p���܂��B

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
*hobby: mes "�Ǐ�": return
*work: mes "���Ј�": return

%href
dcKeys
dcRefValues
dcRefKeysAndValues
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
�v�f�̎擾
%index
dcRefKeysAndValues
�A�z�z�񂩂�L�[�ƒl�̔z����擾

%prm
dict, refKeys, refValues  
dict      : �A�z�z��̃��W���[���^�ϐ�
refKeys   : �L�[�̔z���Ԃ�������z��ϐ�
refValues : �l�̔z���Ԃ��z��ϐ�
            (�^��dcGetType�œ�������̂ɓ�����)

%inst
�A�z�z�񂩂�o�^����Ă���L�[�ƒl�̔z����擾���܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refKeysAndValues@Dictionary���g�p���܂��B

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
*hobby: mes "�Ǐ�": return
*work: mes "���Ј�": return

%href
dcRefKeys
dcRefValues
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
�v�f�̎擾
%index
dcRefValues
�A�z�z�񂩂�l�̔z����擾

%prm
dict, refValues
dict      : �A�z�z��̃��W���[���^�ϐ�
refValues : �l�̔z���Ԃ��z��ϐ�
            (�^��dcGetType�œ�������̂ɓ�����)

%inst
�o�^����Ă���l�̔z����擾���܂��B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����refValues@Dictionary���g�p���܂��B

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
*hobby: mes "�Ǐ�": return
*work: mes "���Ј�": return

%href
dcValues
dcRefKeys
dcRefKeysAndValues
dcForeach
new@Dictionary
news@Dictionary
#define DictionaryAliasOff

%group
�v�f�̎擾
%index
dcRemove
�A�z�z�񂩂�v�f���폜

%prm
dict, key
dict : �A�z�z��̃��W���[���^�ϐ�
key  : �폜����v�f�̃L�[

%inst
�A�z�z�񂩂�v�f���폜���܂��B

�����̌��ʂ�stat�ɑ������A���L�̂悤�ɂȂ�܂��B

stat : ���
-----:------------------------------------
 0   : ����ɏ�������������
 1   : �L�[�����݂��Ȃ����ߏ����Ɏ��s����


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����remove@Dictionary���g�p���܂��B

%sample
#runtime "hsp3cl"
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

mes "�ydcRemove�O�z"
mes dcJoinDict(dict)

dcRemove dict, "hobby"
dcRemove dict, "work"

mes "�ydcRemove��z"
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
�v�f�̕ύX
%index
dcReSet
�A�z�z��̗v�f�ɉ��Z��K�p���čđ��

%prm
dict, key, sign, addValue 
dict     : �A�z�z��̃��W���[���^�ϐ�
key      : ���Z��K�p����v�f�̃L�[
sign     : ���Z�q������������(���L�Q��)
addValue : ���Z���s���l(�����A���V�����_�A������)

%inst
������Z�q�ɑ������閽�߂ł��B
�ݒ肵�����Z�q�ƒl��K�p���čđ�����܂��B

���Z�q������������͎��̑Ή��ƂȂ�܂��B

���Z�q : ������
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

�����̌��ʂ�stat�ɑ������A���L�̂悤�ɂȂ�܂��B

stat : ���
-----:-------------------------------------------
 0   : ����ɏ�������������
 1   : �L�[��������Ȃ������A
     : �܂��͉��Z�q�����������񂪕s���ł��邽�߁A
     : �����Ɏ��s����


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����reSet@Dictionary���g�p���܂��B

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
�v�f�̕ύX
%index
dcSet
�A�z�z��̗v�f�ɒl����

%prm
dict, key, value
dict  : �A�z�z��̃��W���[���^�ϐ�
key   : �o�^����L�[(������)
value : �o�^����l
        (�^�͘A�z�z��̌^(dcGetType)�œo�^����邪�A
         ������A���V�����_�A������Ԃ͊e���ϊ������)

%inst
�A�z�z��̃L�[�ɒl���Z�b�g���܂��B
���x���^�A���W���[���^�̏ꍇ�͌^���قȂ�Ǝ��s���܂��B

�����̌��ʂ�stat�ɑ������A���L�̂悤�ɂȂ�܂��B

stat : ���
-----:------------------------------
 0   : ����ɏ�������������
 2   : �^���قȂ邽�ߏ����Ɏ��s����
     : (���x���^�A���W���[���^�̂�)


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{���߂͎g�p�ł��Ȃ��Ȃ�A�����set@Dictionary���g�p���܂��B

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
	mes "�^���Ⴂ�܂��B"
}
else {
	dcRefItem ldict, "name", item
	gosub item
}

dcSet ldict, "name", "taro"
if stat = 2 {
	mes "�^���Ⴂ�܂��B"
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
�v�f�̕ύX
%index
dcTryGetValue
�A�z�z�񂩂�v�f�̎擾������

%prm
(dict, key, refValue)
val=0,1 : �v�f�̎擾�̉�(0=���s,1=����)
dict : �A�z�z��̃��W���[���^�ϐ�
refValue : �l��Ԃ��ϐ�
           (�^��dcGetType�œ�������̂ɓ�����)

%inst
�A�z�z�񂩂�v�f���擾�ł��邩�����܂��B
�擾�ł����ꍇ��1��Ԃ��ArefValue�ɒl��Ԃ��܂��B  
�ł��Ȃ������ꍇ��0��Ԃ��܂��B 


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����tryGetValue@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
"}

keys = "name", "age", "hobby", "work", "hsp"
sdim item
foreach keys
	if dcTryGetValue(dict, keys(cnt), item) {
		mes item
	}
	else {
		mes "�v�f��������܂���ł����B"
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
�v�f�̎擾

%index
dcValues
�A�z�z��̃C���f�b�N�X����l���擾

%prm
(dict, index)
val   : �擾�����l(�^��dcGetType�œ�������̂ɓ�����)
dict  : �A�z�z��̃��W���[���^�ϐ�
index : �A�z�z��ɓo�^�����v�f�̃C���f�b�N�X

%inst
�A�z�z��̃C���f�b�N�X�ɓo�^����Ă���l���擾���܂��B

���x���^�⃂�W���[���^�̒l�擾�������ꍇ�́A�z��擾�ł�dcRefValues���g�p���Ă��������B


#define DictionaryAliasOff���g�p�����ꍇ�́A
�{�֐��͎g�p�ł��Ȃ��Ȃ�A�����values@Dictionary���g�p���܂��B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
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
�v�f�̎擾
%index
new@Dictionary
�A�z�z��̏�����

%prm
dict, type, keySep, itemSep, initDict
dict        : ����������A�z�z��(���W���[���^�ϐ��ŕԂ�)
type="str"  : �^������������(vartype�Q��)
keySep=":"  : initDict�̃L�[�ƒl�̊Ԃ̋�؂蕶��
itemSep="," : initDict�̗v�f���Ƃ̋�؂蕶��
initDict    : �A�z�z��ɐݒ肷�鏉���l(������)

%inst
�A�z�z�񃂃W���[�������������A�A�z�z��̃��W���[���^�ϐ��𐶐����܂��B
(Dictionary���W���[���R���X�g���N�^)

�A�z�z���z��ϐ��Ɋi�[����ꍇ�͏��������ɔz��ϐ����j������邽�߁Anews@Dictionary�����g�p���������B

%sample
#include "Dictionary.as"

new@Dictionary dict,,,,{"
	name:bob,
	age:40,
	hobby:�Ǐ�,
	work:���Ј�
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
�A�z�z��̒�`
%index
news@Dictionary
�A�z�z��̏�����(�z��p)

%prm
dict, type, keySep, itemSep, initDict
dict        : ����������A�z�z��(���W���[���^�ϐ��ŕԂ�)
type="str"  : �^������������(vartype�Q��)
keySep=":"  : initDict�̃L�[�ƒl�̊Ԃ̋�؂蕶��
itemSep="," : initDict�̗v�f���Ƃ̋�؂蕶��
initDict    : �A�z�z��ɐݒ肷�鏉���l(������)

%inst
�A�z�z�񃂃W���[�������������A�A�z�z��̃��W���[���^�ϐ��𐶐����܂��B
(Dictionary���W���[���R���X�g���N�^)

�{���߂�new@Dictionary�̔z��������߂ł���A�z��ϐ��̔j���͂���܂���B

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
�A�z�z��̒�`

