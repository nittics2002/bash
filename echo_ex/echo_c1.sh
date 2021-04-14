#!/bin/bash
#
# カラーecho 8bit
#
#  echo_c1.sh $colorset [echo options] string
#

set -e
#set -x

#色シンボルテーブル
declare -A color_table=( \
  [0]="none" \
  [1]="red" \
  [2]="green" \
  [3]="yellow" \
  [4]="blue" \
  [5]="magenta" \
  [6]="cyan" \
  [7]="white" \
)

#
# 色シンボル=>色コード変換
#
# @param $1 f:foreground color
#           b:background color
# @param $2 symbol
# @return $ret
function color_symbol_to_code()
{
  #色シンボル小文字化
  local lowercase_symbol="${2,,?}"

  #色シンボルテーブルを検索
  for (( i=0; i<${#color_table[@]}; i++ )) ;
  do
    local first_char="${color_table[$i]:0:1}"

    if [[ ${lowercase_symbol:0:1} == $first_char ]] ;
    then
      local color_no="$i"
      break;
    fi
  done

  #一致あり
  if [[ -n $color_no ]] ;
  then
    #色タイプ
    local color_type=${1,,}
    
    #全景色
    if [[ $color_type == f ]] ;
    then
      ret="3$i"
    elif [[ $color_type == b ]] ;
    then
      ret="4$i"
    else
      ret=
    fi
  else
    ret=
  fi
}


#main
declare -a argv=()
declare -i argc=0
first_list=1

while (( $# > 0 )) ;
do
  #第１引数は色名称
  if [[ $first_list == 1 ]] ;
  then
    #:で配列に分割
    declare -a colors=(${1/:/ })

    #分割配列数が2つ以上
    if [[ ${#colors[@]} -ge 2 ]] ;
    then
      :
    #色名称と分割配列[0]がと同じ
    #=前景色
    elif [[ ${colors[0]} == $1 ]] ;
    then
      colors[1]=none
    #背景色
    else
      colors[1]=${colors[0]}
      colors[0]=white
    fi

    first_list=0
  else
    argv+=( "$1" )
    argc=$(( ++$argc ))
  fi
  shift
done

[[ "${#argv[@]}" < 1 ]] && \
  cat <<- EOL1 && exit 11
  
  echo 8bitカラー
    echo_c1.sh colorset [echo options] string
      colorset 色名称([前景色][:背景色])
          n または none
          r または red
          g または green
          y または yellow
          b または blue
          m または magenta
          c または cyan
          w または white
    
    echo_c1.sh red 前景色が赤
    echo_c1.sh :red 背景色が赤
    echo_c1.sh red:blue 前景色が赤 背景色が青
    echo_c1.sh r:B -n 前景色が赤 背景色が青 echoオプション-n(改行なし)

EOL1

ret=
color_symbol_to_code f "${colors[0]}"
forecolor="$ret"

ret=
color_symbol_to_code b "${colors[1]}"
backgroundcolor="$ret"


echo -e "\e[${forecolor};${backgroundcolor}m${argv[${argc}]}\e[m"


