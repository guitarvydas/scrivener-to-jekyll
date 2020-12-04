#!/bin/bash

rm -f _posts/*.html
cp test.html test1.html

wire3=wire_$RANDOM
wire4=wire_$RANDOM
wire5=wire_$RANDOM
mkfifo ${wire3} ${wire4} ${wire5}

./move-to-posts.bash 3<${wire3} 4<${wire4} 5<${wire5} &
pid=$!

echo test1.html >${wire3}
echo 2020-12-03 >${wire4}
echo true >${wire5}

wait ${pid}
