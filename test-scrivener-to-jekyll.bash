#!/bin/bash

rm -f test1.html filename go _posts/* assets/*

mkfifo filename
mkfifo go

cp test.html test1.html

./isADirectory 3<${wire1c} 4>${wire3} 5>${wire4} &
pida=$!
./

echo test1.html > ${filename} &
echo "true" > ${go} &


