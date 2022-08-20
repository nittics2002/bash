#!/bin/bash

file=test02.sh.htm

#子要素(唯一の要素から子要素の属性)
cat "${file}" | \
    sed -r '/<\/form>/q' | \
    tac | \
    sed -r '/<form /q' | \
    tac | \
    grep "class='submit'" | \
    sed -r 's/^.+type="//' | \
    rev | \
    sed -r 's/^.*"//' | \
    rev

