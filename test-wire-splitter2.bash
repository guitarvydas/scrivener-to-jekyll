#!/bin/bash

fifo3=fifo_$RANDOM
fifo4=fifo_$RANDOM
fifo5=fifo_$RANDOM
mkfifo ${fifo3} ${fifo4} ${fifo5}

./wire-splitter2 3<${fifo3} 4>${fifo4} 5>${fifo5}&
pid=$!

echo data-on-port-3 >${fifo3}

# grrr, each fifo must have 2 active ends, or blocking will occur
#  (the fifos are buffered, but *only after* both ends have been established)
# hence, above call to wire-splitter2 will block until something attaches to fifo5
# hence, we must & the port 4 line
echo "port 4:" /`cat - <${fifo4}`/ &
echo "port 5:" /`cat - <${fifo5}`/

wait $pid

