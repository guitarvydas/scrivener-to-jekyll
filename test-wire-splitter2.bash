#!/bin/bash

fifo3=fifo_$RANDOM
fifo4=fifo_$RANDOM
fifo5=fifo_$RANDOM
mkfifo ${fifo3} ${fifo4} ${fifo5}

./wire-splitter2 ${fifo3} ${fifo4} ${fifo5} &
pid=$!

echo hello testing testing >${fifo3}
cat - <${fifo4}
cat - <${fifo5}

wait $pid
