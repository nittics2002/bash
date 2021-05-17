#!/bin/bash
#
# vimに存在し,notepad++に無い関数のシンタックスハイライト
#
#
#

set -e
#set -x

npp_xml=./langs.xml.txt
vim_xml=/usr/share/vim/vim82/syntax/php.vim

comm -13 <( \
  tr ' ' '\n' < "$npp_xml" \
    | sed -r -e '/^$/d' \
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
\


