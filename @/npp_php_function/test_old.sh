#!/bin/bash
#
# vimに存在し,notepad++に無い関数のシンタックスハイライト
#
#
#

set -e
#set -x

npp_xml=./php.xml
vim_xml=/usr/share/vim/vim82/syntax/php.vim

comm -13 <( \
  sed -r -n -e '/<KeyWord/p' "$npp_xml" \
    | sed -r -e 's/^.*<.+name="//' \
    | sed -r -e 's/".+>//' \
    |sort \
  ) \
  <( \
  sed -r -n '/phpFunctions.+contained/p'  < "$vim_xml" \
    |sed -r 's/^.+phpFunctions //' \
    |sed -r 's/contained.*$//' \
    |tr ' ' '\n' \
    |sed -r -n '/\S+/p' \
    |sort
  ) \
    |sed -r 's/^(\S*)/<KeyWord name="\1" func="yes">/' \
    |sed -r 'a \
</KeyWord>' \



