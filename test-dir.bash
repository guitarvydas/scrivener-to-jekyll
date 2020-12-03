#!/bin/bash
rm -f fifo
mkfifo fifo
echo "paul" > fifo &
./isADirectory.bash 3< fifo
echo "../" > fifo &
./isADirectory.bash 3< fifo
