#!/bin/bash
#
## inputs:
## filename (fd 3)
## go (fd 4)
## content (fd 5) N/C
#
## outputs:
## <none> - side-effect - file.html moved to ./_posts/<prefix>_filename.html
#

wire1=wire_$RANDOM
wire1a=wire_$RANDOM
wire1b=wire_$RANDOM
wire2=wire_$RANDOM
wire2a=wire_$RANDOM
wire2b=wire_$RANDOM
wire3=wire_$RANDOM
mkfifo ${wire1} ${wire1a} ${wire1b} ${wire2} ${wire2a} ${wire2b} ${wire3}

./create-file-prefix.bash 3<${wire1a} 4<${wire2a} 5>${wire3} &
pid1 = $!
./move-to-posts.bash 3<${wire1b} 4<${wire3} 5<${wire2b} &
pid2 = $!
./wire-splitter 3<${wire1} 4>${wire1a} 5>${wire1b}&
pid3 = $!
./wire-splitter 3<${wire2} 4>${wire2a} 5>${wire2b}&
pid4 = $!

read -u 3 var_filename
read -u 4 var_go



var_filename=""
running="true"
while test "true" = ${running}
    read -n 512 -u 4 var_go
    if test -n ${var_go}
    then
	running="false"
    else
	read -n 512 -u 3 var_temp
	if test -n ${var_temp}
	then
	    echo ${var_temp} >wire1
	fi
    fi
done
echo "go" >wire2
wait ${create_file_prefix_pid} ${move_to_posts_pid}      
exit 0



## pseudo code
#
# initialize filename to empty
# while running
# do
#     go = non-blocking-read port["go"]
#     if go {
# 	    exit loop
#     } else {
# 	   temp = non-blocking-read port["filename"]
# 	   if temp {
# 	      send temp to create-file-prefix["filename"], move-to-posts["filename"]
# 	   }
#     }	      
# end while
# send "go" to create-file-prefix["go"], move-to-posts["go"]
#
#
## pseudo code with more detail
#
# self.input filename --> wire10[3]
# self.input go --> wire20[3]

# wire10 --> wire10a, wire10b
# wire10a --> create-file-prefix.bash[3]
# wire10b --> move-to-posts.bash[3]

# wire20 --> wire20a, wire20b
# wire20a --> create-file-prefix.bash[4]
# wire20b --> move-to-posts.bash[5]

# wire30 --> move-to-posts.bash[4]

# initialize filename to ""
# initialize running to "true"
# while running == "true"
# do
#     go = read fd 3 
#     if go {
# 	    set running = "false"
#     } else {
# 	   temp = read fd 4
# 	   if temp is not empty {
# 	      send temp to wire10
# 	   }
#     }	      
# end while
# send "go" to wire20


