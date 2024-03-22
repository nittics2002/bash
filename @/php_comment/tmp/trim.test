#
# trim
#
# @param string str
# @return string
#
function trim(  str)
{
    gsub(/^[[:space:]]+/, "", str)
    gsub(/[[:space:]]+$/, "", str)
    return str 
}

{
    trimed = trim($0)
    print trimed
}
