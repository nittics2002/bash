#!/bin/sh
#
#   フォルダ更新監視
#
#

set -e
set -x

if [ $# -ne 3 ]; then
    echo <<- EOL

    watch_dir.sh TARGET_DIR WAIT_TIME_SEC COMMAND
        TARGET_DIR 監視ディレクトリ
        WAIT_TIME_SEC 監視間隔(秒)
        COMMAND 実行コマンド

EOL

    exit 1
fi

echo "監視対象 $1"
echo "監視間隔 $2"
echo "実行コマンド $3"


TARGET_DIR="$1"
WAIT_TIME_SEC="$2"
COMMAND="$3"

WATCH_COMMAND='ls --full-time "$1" | awk '{print "$7"-"$8"}'

last="$(WATCH_COMMAND)"


while true; do
        sleep $INTERVAL

        current=`ls --full-time "$1" | awk '{print $7"-"$8}'`
        
        if [ $last != $current ] ; then
                echo "$current"
                last=$current
                eval $3
        fi
done

