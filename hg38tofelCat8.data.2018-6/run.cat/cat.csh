#!/bin/csh -ef
find ../psl/$1/ -name "*.psl" | xargs cat | gzip -c > $2
