#!/bin/bash

rm -f _posts/*.html
cp test.html test1.html

rm -rf fifo3 fifo4 fifo5
mkfifo fifo3 fifo4 fifo5

./create-file-prefix.bash 3<fifo3 4<fifo4 5>fifo5 &
pid=$!

echo test1.html >fifo3
echo true >fifo4
cat - <fifo5
wait ${pid}
