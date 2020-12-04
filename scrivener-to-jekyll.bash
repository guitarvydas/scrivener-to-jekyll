#!/bin/bash
echo "* $0"

## inputs
## port 3 --> filename
## port 4 --> go
#
## outputs
## <none> - side effect creates a file in ./_post and, maybe in ./assets/
#
rm -f wire_*

wire1=wire_$RANDOM
wire1a=wire_$RANDOM
wire1b=wire_$RANDOM
wire1c=wire_$RANDOM

wire2=wire_$RANDOM
wire2a=wire_$RANDOM
wire2b=wire_$RANDOM

wire3=wire_$RANDOM
wire4=wire_$RANDOM

mkfifo ${wire1}
echo "" >${wire1} &
read junk <${wire1} &

mkfifo ${wire1a}
echo "" >${wire1a} &
read junk <${wire1a} &

mkfifo ${wire1b}
echo "" >${wire1b} &
read junk <${wire1b} &

mkfifo ${wire1c}
echo "" >${wire1c} &
read junk <${wire1c} &

mkfifo ${wire2}
echo "" >${wire2} &
read junk <${wire2} &

mkfifo ${wire2a}
echo "" >${wire2a} &
read junk <${wire2a} &

mkfifo ${wire2b}
echo "" >${wire2b} &
read junk <${wire2b} &

mkfifo ${wire3}
echo "" >${wire3} &
read junk <${wire3} &

mkfifo ${wire4}
echo "" >${wire4} &
read junk <${wire4} &


# sub components
./wire-splitter3 3<${wire1} 4>${wire1a} 5>${wire1b} 6>${wire1c} &

./isADirectory.bash 3<${wire1c} 4>${wire3} 5>${wire4} &
set -v
echo hello >${wire1} &
read junk <${wire1a} &
read junk <${wire1b} &
read junk <${wire1c} &
read junk <${wire3} &
read junk <${wire4} &

wait
echo done
