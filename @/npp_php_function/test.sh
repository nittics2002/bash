#!/bin/bash
#
# vimに存在し,notepad++に無い関数のシンタックスハイライト
#
#
#

set -e
#set -x

npp_xml=./langs.xml.txt
ide_xml=./webStrorm.php.xml

comm -13 <( \
  tr ' ' '\n' < "$npp_xml" \
    | sed -r -e '/^$/d' \
    |sort \
  ) \
  <( \
  sed -n -r -e '/<keywords keywords="/p' <"$ide_xml" \
    | sed -r -e 's/^.+<keywords keywords="//' \
    | sed -r -e 's/"\s+ignore.+\/>$//' \
    | tr ';' '\n' \
    | sed -r -e '/^.+::.+$/d' \
    |sort \
  ) \



