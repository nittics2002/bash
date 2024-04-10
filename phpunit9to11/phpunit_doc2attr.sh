#!/bin/bash
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
    phpunit_doc2attr.sh FILE|DIR

EOL

}

[[ $# -ne 1 ]] && usage && exit 1

if [[ -f $1 ]]
then
	mv "$1" "$1.old"
    awk -f phpunit_doc2attr.awk "$1.old" > "$1"
elif [[ -d $1 ]]
then
    find "$1" -type f -name "*Test.php" |
        xargs -I {} bash -c "mv {} {}.old && awk -f phpunit_doc2attr.awk {}.old >{}"
else
    usage
    exit 2
fi
