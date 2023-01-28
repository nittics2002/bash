#!/bin/bash
#
# arrayを使わない方法はあるか
#
#   方法はあるが面倒が多い
#   arrayを使って必要時にstdin/out使う方が良さげ
#

##数値定義&初期化

str_array='aaa AAA
bbb BBB
ccc CCC
ddd DDD'

echo
echo "##定義&初期化"

for x in "${str_array}"
do
    echo "${x}"

done

##push

echo
echo "##push"

str_array+='
eee DDD'

for x in "${str_array}"
do
    echo "${x}"

done

##pop(値取得無し)

echo
echo "##pop(値取得無し)"

str_array=$(IFS= ; printf '%s\n' ${str_array} |sed '$d')

for x in "${str_array}"
do
    echo "${x}"
done

##unshift

echo
echo "##unshift"

str_array="eee EEE
${str_array}"

for x in "${str_array}"
do
    echo "${x}"

done

##shift(値取得無し)

echo
echo "##pop(値取得無し)"

str_array=$(IFS= ; printf '%s\n' ${str_array} |sed '1d')

for x in "${str_array}"
do
    echo "${x}"
done

##値参照 arr[n]

echo
echo "##値参照"

val=$(IFS= ; printf '%s\n' ${str_array} |sed -n '2p')
echo "${val}"

##値代入 arr[n]=val

echo
echo "##値代入"

str_array=$(IFS= ; printf '%s\n' ${str_array} |sed '2i \
eee EEE')

for x in "${str_array}"
do
    echo "${x}"

done









