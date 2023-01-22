#

##230122

- xpathの解析は
    - / でパス構成をarray分割する("に注意)
    - array毎に軸 名前空間 ノードテストを抽出する
    - デバッグできるよう 各抽出を順番に行う
        - 1文字毎にshanting yardみたいな処理で一気に抽出しない
        - パス分割=>軸抽出=>名前空間=>ノードテスト を抽出する





##230121

htmlの整理test03.sh

- 変換後一時ファイルの各行をtagで始めたい
    - text()部分はtagの後ろに移動したい
    - textarea などで tag以外に<があると改行されている
    - < でなく \<tag のようなpatternは色々あり最長マッチのため困難
    - sed hold spaceかawkで開始がtag以外の行を移動する?

- xpath解析準備
    - 変換後一時ファイルを最終行から読み込む
    - 構造を把握するためインデントを把握する
    - 終了tag枚にインデント数を算出しarrayかtmpfileに保持

- xpathの値検索方法案
    - xpath式を順番に検索する
    - あるいはgrepで個別に軸やノードテストに一致する条件行を抽出
    - 抽出した中からxpath式に一致するtagまたは値を調査する
    


## 230120

###xpath

基本(省略)構文

- /aaa/bbb/ccc rootよりaaa bbbのccc tag
- //aaa/bbb/ccc 起点aaaよりbbbのccc tag
- //aaa//bbb/ccc 起点aaaの子孫bbbのccc tag
- //aaa/bbb/ccc[n] 起点aaaよりbbbのn番目のccc tag
- //aaa/../bbb aaaの親のbbb tag
    - 参考までに.は自身を示す
- //aaa/./bbb aaaddの親のbbb tag
    - 本scriptでは属性値取得とする?


完全構文
/軸方向::名前空間:ノードテスト[述語]/～～

- 本scriptでは省略構文を使う

- //aaa/child::bbb aaaの子bbb tag
- //aaa/descendant::bbb aaaの子孫bbb tag
- //aaa/parent::bbb aaaの親bbb tag
- //aaa/ancestor::bbb aaaの祖先bbb tag
- //aaa/attribute::bbb 属性bbbのaaa tag
    - 本scriptでは本書式は使わずノードテストで指定する?

ノードテスト

- text() tagのテキスト
- * すべて

述語

- //aaa[@bbb='ccc'] 属性bbb=cccのaaa tag

演算子

- 算術 + - * div mod
- 比較 = != > >= < <=
- 論理 and or |

関数

- 文字列 concat() substring() contains() start-with() end-with() string-length()
- 数値 sum()
- 情報 position() count()
- 変換 string() number() boolean()


###reference

xpath wiki
https://ja.wikipedia.org/wiki/XPath

xpathについて
https://www.octoparse.jp/blog/xpath-introduction/

xpath関数(W3C/MDN)
https://developer.mozilla.org/ja/docs/Web/XPath/Functions



