# bash のnumber操作

##数値について

###定義

```bash
declare -i int #整数
typeset -i int #declareの別表現
local -i int
readonly -i int

```

###初期化

```bash
#定数代入
declare -i int=123
typeset -i int=123
local -i int=123
readonly i- int=123

#演算結果代入
declare -i int=1+2+3
```

###let式

```bash
let int=1+2+3

#結果0でなければ戻り値0

```

###算術評価(複合コマンド)

```bash
((int=1+2+3))
for((cnt=0; cnt<10; cnt++)) #変数名num $numではない

#結果0でなければ戻り値0
#letと同じ

```

###算術式展開

```bash
echo $((1+2+3))
echo $((num+3)) #変数名num $numではない

```

###式評価expr

```bash
expr 1+2+3

```

###基数

```bash
#10進数
$((1234)) #1234

#8進数
$((0755)) #493

#16進数
$((0xFF)) #255

#n進数
$((2#1101)) #2進数 13
$((64#ak3)) #64進数 43907

#詳細はman bashの算術式評価参照

```

###算術式評価

((expr))等で使用

優先順に

後置 id++ id--
前置 ++id --id
単項式 + -
論理否定ビット否定 ! ~
累乗 **
乗除 * / %
加減 + -
シフト << >>
比較 <= >= < >
等価 == !=
ビットAND &
ビット排他OR ^
ビットOR |
論理AND &&
論理OR ||
3項式 exp?exp:exp
代入 = *= /= %= += -= <<= >>= &= |=
コンマ exp , exp

###条件式

[[ expression ]]等で使用

-eq -ne -lt -le -gt -ge







###任意精度計算言語bc

man bc参照



##資料

Bash $((算術式)) のすべて - A 基本編
https://qiita.com/akinomyoga/items/9761031c551d43307374


