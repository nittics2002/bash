#!/bin/bash
#
# 複数mktempファイル処理 
#
#

#
#   clean_tmpfiles
#
#   @param int exit_status
#   @param &array file_path
#
function clean_tempfiles()
{
    local status=$1
    shift
    declare -n file_paths="$@"

#終了ステータス
echo $status
#一時ファイルパス
echo "${file_paths[@]}"




    [[ ${#file_paths[@]} == 0 ]] && exit 0

    echo "${file_paths[@]}" |xargs rm -f

    exit $status
}

#複数の一時ファイルを配列変数とする
tmpfile[0]=$(mktemp)
tmpfile[1]=$(mktemp)
tmpfile[2]=$(mktemp)

#正常終了,ctrl+c,pipe異常,プロセス停止時実行
#trap時に一時ファイルを削除する
#終了ステータスと一時ファイル配列へのリファレンスを引数
trap 'clean_tempfiles $? tmpfile' EXIT INT PIPE TERM


echo "${tmpfile[@]}"


exit 1






