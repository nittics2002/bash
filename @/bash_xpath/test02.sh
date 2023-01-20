#!/bin/bash
#
# xpathルール
#
#

function destruct()
{
    



tmpfile[0]=$(mktemp)


sed -E -e 's/</\n</g' | \
    sed -E -e '/^$/d' | \
    sed -E -e '/^\s+$/d'







