#!/bin/bash
echo "* $0"

rm -f test1.html filename go _posts/* assets/*

mkfifo filename
mkfifo go

cp test.html test1.html

./scrivener-to-jekyll.bash 3<filename &

echo test1.html > filename &

wait


