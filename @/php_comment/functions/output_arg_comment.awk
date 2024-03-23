#
# 引数コメント出力
#
# @param string row
# @param string indent
#
function output_arg_comment(  row, indent)
{
    split(row, ar, /\$/)

    type = trim(ar[1])

    if(length(type) == 0) {
        type = "mixed"
    }

    param = "$"trim(ar[2])

    print sprintf("%s* @param %s %s", indent, type, param)
}
