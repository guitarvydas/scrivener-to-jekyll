#!/bin/bash

rm -f _posts/*.html
cp test.html test1.html

wire3=wire_$RANDOM
wire4=wire_$RANDOM
wire5=wire_$RANDOM
mkfifo ${wire3} ${wire4} ${wire5}

./pathA.bash 3<${wire3} 4<${wire4} 5<${wire5} &
pid=$!

echo test1.html >${wire3}
echo true >${wire4}
echo dont-care >${wire5}
wait ${pid}
