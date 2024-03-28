#
# 関数コメント出力
#
# @param string row
# @param string indent
#
function output_function_comment(  row, indent)
{
    split(row, ar, /function/)

    name = trim(ar[2])

    gsub(/\(/, "", name)

    print sprintf("%s* %s", indent, name)
}
