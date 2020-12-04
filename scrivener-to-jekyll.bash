#!/bin/bash

## inputs
## port 3 --> filename
## port 4 --> go
#
## outputs
## <none> - side effect creates a file in ./_post and, maybe in ./assets/
#
wire1=wire_$RANDOM
wire1a=wire_$RANDOM
wire1b=wire_$RANDOM
wire1c=wire_$RANDOM

wire2=wire_$RANDOM
wire2a=wire_$RANDOM
wire2b=wire_$RANDOM

wire3=wire_$RANDOM
wire4=wire_$RANDOM

mkfifo ${wire1} ${wire1a} ${wire1b} ${wire1c}
mkfifo ${wire2} ${wire2a} ${wire2b}
mkfifo ${wire3} ${wire4}

# sub components
./wire-splitter2 3<${wire1} 4>${wire1a} 5>${wire1b} &
pida=$!
./wire-splitter2 3<${wire2} 4>${wire2a} 5>${wire2b} &
pidb=$!

./isADirectory 3<${wire1c} 4>${wire3} 5>${wire4} &
pidc=$!
./pathA 3<${wire1a} 4<${wire2a} 5<${wire3} &
pidd=$!
./pathB 3<${wire1a} 4<${wire2a} 5<${wire4} &
pide=$!


wait ${pida} ${pidb} ${pidc} ${pidd} ${pide}

