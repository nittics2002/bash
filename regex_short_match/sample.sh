#!/bin/bash

cat container.php \
    |tr '\n' '\t' \
    |perl -p -e 's/(\/\*\*.+?)\*\//\1AAA/g' \
    |tr '\t' '\n'
