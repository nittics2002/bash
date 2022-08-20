#!/bin/bash

file=test01.sh.htm

#子要素(唯一の要素から子要素の属性)
cat "${file}" | \
    tac | \
    sed -r '/<head>/q' | \
    tac | \
    sed -n -r '/<link /p' | \
    sed -n -r '/href=/p' | \
    sed -r 's/^.+ href="(.+)".*$/\1/' | \
    rev | \
    sed -r 's/.*"//' | \
    rev





