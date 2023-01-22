# bash のstring操作

##文字列について

###定義

```bash
declare str
typeset str
local str
readonly str

```

###初期化

```bash
declare str=abc
typeset str=abc
local str=abc
readonly str=abc

```

###パラメータ展開

```bash

#文字数
${#param} #abc 3

#抽出
${param:offset:length} #{abcdefgh:3:}2 cd
${param:offset:length} #{abcdefgh: -3} fgh offset empty only

#前方一致削除
${param#word} #{/aaa/bbb/ccc/ddd#*}/ aaa/bbb/ccc/ddd 最短マッチ
${param##word} #{/aaa/bbb/ccc/ddd##*/} ddd 最長マッチ

#後方一致削除
${param%word} #{/aaa/bbb/ccc/ddd%/*} /aaa/bbb/ccc/ 最短マッチ
${param%%word} #{/aaa/bbb/ccc/ddd%%/*} {empty}  最長マッチ

#置換(最長一致)

#patternはman bash パターンマッチ参照
#特殊パターン(基本)は* ? [
#拡張パターンは ?() *() +() @() !()

##最初にマッチを置換 /pattern
${param/pattern/replacement} #{aaa_bbb_aaa_bbb/bb/BB} aaa_BBb_aaa_bbb

##全て置換 //pattern
${param/pattern//replacement} #{aaa_bbb_aaa_bbb//bb/BB} aaa-BBb-aaa-BBb

##文字列先頭にマッチを置換 /#  (^と同じ動作)
${param/#pattern/replacement} #{aaa_bbb_aaa_bbb/#aa/AA} AAa_bbb_aaa_bbb

##文字列最後にマッチを置換 /%  ($と同じ動作)
${param/%pattern/replacement} #{aaa_bbb_aaa_bbb/%bb/BB} aaa_bbb_aaa_bBB

##位置パラメータは全パラメータに適用
#$1=aa_bb_aa $2=bb_aa_bb
#{@//aa/AA} $1=AA_bb_aa $2=bb_AA_bb
#{*//aa/AA} $1=AA_bb_aa $2=bb_AA_bb

##配列も全パラメータに適用
#arr[0]=aa_bb_aa arr[1]=bb_aa_bb
#{arr[@]//aa/AA} $arr[0]=AA_bb_aa $arr[1]=bb_AA_bb
#{arr[*]//aa/AA} $arr[0]=AA_bb_aa $arr[1]=bb_AA_bb

```

###条件式 [[ ]]

man bash のパターンマッチで比較
== !=

ロケール順に比較
< >

拡張正規表現で比較
=~ =! 


###クォート

詳細はman bash クォート

ソースの改行
\<newline>

シングルクォート
パラメータの展開無し
'文字は書けない

ダブルクォート
パラメータを展開する

バックスラッシュエスケープシーケンスデコード
書式 $'string' 特殊文字をANSI C展開する
書式 $"string" 特殊文字をロケール展開する

```

###ヒアドキュメント

ファイルとして標準入力

```bash

#変数を展開 先頭TAB文字そのまま
aaa=AAA; cat <<EOL
	$aaa
	    BBB
	        CCC
EOL

#変数を展開 先頭TAB文字削除
aaa=AAA; cat <<-EOL
	$aaa
	    BBB
	        CCC
EOL
	
#word(EOL)クォート(' or ")すると変数の展開無し
aaa=AAA; cat <<"EOL"
	$aaa
	    BBB
	        CCC
EOL

```

###ヒアストリング

```bash
#文字列を標準入力 文字列をクォートで囲う
tr a-z A-Z <<< "abc
	def
		dgi"

#シングルクォートもOK
tr a-z A-Z <<< 'abc
	def
		dgi'

#変数を展開する
aaa=def;tr a-z A-Z <<< "abc
	$aaa
		dgi"

#変数は展開しない
aaa=DEF; tr a-z A-Z <<< 'abc
	$aaa
		dgi'

```







##資料

Bash $((算術式)) のすべて - A 基本編
https://qiita.com/akinomyoga/items/9761031c551d43307374


