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

rm -f wire1, wire1a, wire1b, wire2, wire2a, wire2b, wire3
mkfifo wire1 wire1a wire1b wire2 wire2a wire2b wire3

./create-file-prefix.bash 3<wire1a 4<wire2a 5>wire3 &
create_file_prefix_pid = $!
./move-to-posts.bash 3<wire1b 4<wire3 5<wire2b &
move_to_posts_pid = $!

var_filename=""
running="true"
while test "true" = ${running}
    read -n -u 4 var_go
    if test -n ${var_go}
    then
	running="false"
    else
	read -n -u 3 var_temp
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
# self.input filename --> wire1[3]
# self.input go --> wire2[3]

# wire1 --> wire1a, wire1b
# wire1a --> create-file-prefix.bash[3]
# wire1b --> move-to-posts.bash[3]

# wire2 --> wire2a, wire2b
# wire2a --> create-file-prefix.bash[4]
# wire2b --> move-to-posts.bash[5]

# wire3 --> move-to-posts.bash[4]

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
# 	      send temp to wire1
# 	   }
#     }	      
# end while
# send "go" to wire2


