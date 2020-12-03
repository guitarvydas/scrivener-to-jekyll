#!/bin/bash
rm -f fifo
mkfifo fifo
rm -f no
rm -f yes

echo "paul" > fifo &

./isADirectory.bash 3<fifo 4>isDir 5>notDir
echo isDir is /`cat isDir`/
echo notDir is /`cat notDir`/

rm -f isDir
rm -f notDir

echo "../" > fifo &

./isADirectory.bash 3<fifo 4>isDir 5>notDir
echo isDir is /`cat isDir`/
echo notDir is /`cat notDir`/
