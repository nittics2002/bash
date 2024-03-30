#
# phpunit doc-comment attribute 変換
#
# @version
#
set -e
set -x

#####
#usage
#####
function usage() {
    cat <<EOL

usage
    method_comment.sh FILE|DIR

EOL

}

#####
#main
#####
[[ $# -ne 1 ]] && usage && exit 1

script_path="$(dirname $0)"

if [[ -f $1 ]]
then
    awk \
        -f "${script_path}/method_comment.awk" \
        -f "${script_path}/functions/output_arg_comment.awk" \
        -f "${script_path}/functions/output_function_comment.awk" \
        -f "${script_path}/functions/output_return_comment.awk" \
        -f "${script_path}/functions/trim.awk" \
        "$1" > "$1.new"
        
elif [[ -d $1 ]]
then
    find "$1" -type f -name "*Test.php" |
        xargs -I {} bash -c "awk -f method_comment.awk {} >{}.new"
else
    usage
    exit 2
fi
