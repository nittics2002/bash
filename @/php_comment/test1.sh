#
# phpunit doc-comment attribute 変換
#
# @version
#
set -e
#set -x

function usage() {
    cat <<EOL

usage
    method_comment.sh FILE|DIR

EOL

}

[[ $# -ne 1 ]] && usage && exit 1

if [[ -f $1 ]]
then
    awk -f method_comment.awk "$1" > "$1.new"
elif [[ -d $1 ]]
then
    find "$1" -type f -name "*Test.php" |
        xargs -I {} bash -c "awk -f method_comment.awk {} >{}.new"
else
    usage
    exit 2
fi
