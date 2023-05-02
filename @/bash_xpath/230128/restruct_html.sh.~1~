#!/bin/bash
#
# 標準入力の<を改行,空行を削除
#

sed -E -e 's/</\n</g' | \
    sed -E -e '/^$/d' | \
    sed -E -e '/^\s+$/d'


