#
# 戻値コメント出力
#
# @param string row
# @param string indent
#
function output_return_comment(  row, indent)
{
    split(row, ar, /:/)

    gsub(/[^A-Za-z0-9_]/, "", ar[2])

    print sprintf("%s* @return %s", indent, ar[2])
}
