# bash のarray 操作

##配列について

###定義

```bash
arr=()
declare arr=()
declare -a arr #数値配列
declare -A assoc #連想配列

readonly -a arr
readonly -A assoc

#typesetはdeclareと同じ
typeset -a arr
typeset -A assoc

```

###初期化

```bash
#複合代入
arr=( aaa bbb ccc )
IFS=,;arr=( aaa,bbb,ccc )

#個別代入
arr[0]=aaa
arr[aaa]=AAA

```

###参照

```bash
#全要素
${arr[@]} #aaa bbb ccc
${arr[*]}

"${arr[@]}" #"aaa" "bbb" "ccc"
"${arr[*]}" #"aaa bbb ccc"

#個別
${arr[0]} #aaa

###削除

```bash
#個別
unset arr[0]

#一括
unset arr
unset arr[@]
unset arr[*]

```

###要素数

```bash
${#arr[@]}
${#arr[*]}

```

###全添字参照

```bash
echo "${!arr[@]}" #"0" "1" "2"
echo "${!arr[*]}" #"0 1 2"

echo "${!assoc[@]}" #"aaa" "bbb" "ccc"
echo "${!assoc[*]}" #"aaa bbb ccc"

```

###ループ

```bash
#値ループ
for val in "${arr[@]}"
do
    echo "${val}"
done

#キーループ
for key in "${!arr[@]}"
do
    echo "${arr[${key}}"
done

#indexループ
for (( i=0; i<"${#arr[@]}"; i++ ))
do
    echo "${arr[${i}]}"
done

```

###演算

```bash
#末尾追加push
arr+=(ddd eee)
arr=("${arr[@]}" ddd eee)

#先頭追加unshift
arr=(ddd eee "${arr[@]}")

```

###スライスslice

```bash
"${arr[@]:1:3]" #bbb ccc ddd

#末尾(1要素のみ可能)
"${arr[@]: -1]" #eee

```

###結合join

```bash
( IFS=, ; echo "${arr[*]}" ) #aaa,bbb,ccc,ddd,eee

```

###関数の引数として配列

```bash

#リファレンス渡し
function child()
{
    declare -n argv="$@" #名前参照

    for x in "${argv[@]"
    do
        echo "${x}"
    done
}

function parent()
{
    arr= (aaa bbb ccc)
    parent arr #リファレンス渡し
}

parent

```

###関数の戻り値として配列

```bash
function child()
{
    arr=(aaa bbb ccc)
    
    echo "${arr[*]}"
    #区切り文字を空白以外にしたい場合
    ( IFS=, echo "${arr[*]}" )
}

function parent()
{
    arr=$(child)
    #区切り文字を空白以外にしたい場合
    { IFS=, ; arr=$(child) ; }

    for x in "${arr[@]}"
    do
        echo "${x}"
    done
}

parent

echo xxx${IFS}xxx #xxx XXX IFSは影響なし

```



##参考

bashの配列のまとめ（定義・代入・参照と取得・ループ）
https://takuya-1st.hatenablog.jp/entry/2016/12/27/053456

bashの配列とは？事例で分かる配列の使い方をまとめて紹介
https://and-engineer.com/articles/YRsLrhAAACRz7nVV


