#!/bin/bash
echo "* $0"

target=test1.html
rm -f test1.html filename go _posts/* assets/*
mkfifo filename
mkfifo go
cp test.html ${target}

./scrivener-to-jekyll.bash 3<filename &

echo ${target} > filename &
echo "go" > go &

echo "** done $0"
