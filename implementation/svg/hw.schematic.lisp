(((:ITEM-KIND . "leaf") (:NAME . "string-join") (:IN-PINS "a" "b") (:OUT-PINS "c" "error") (:KIND . "string-join") (:FILENAME . "$/parts/cl/string-join.lisp")) ((:ITEM-KIND . "leaf") (:NAME . "world") (:IN-PINS "start") (:OUT-PINS "s" "error") (:KIND . "world") (:FILENAME . "$/parts/cl/world.lisp")) ((:ITEM-KIND . "leaf") (:NAME . "hello") (:IN-PINS "start") (:OUT-PINS "s" "error") (:KIND . "hello") (:FILENAME . "$/parts/cl/hello.lisp")) ((:ITEM-KIND . "graph") (:NAME . "hw") (:GRAPH (:NAME . "HW") (:INPUTS "START") (:OUTPUTS "RESULT") (:PARTS ((:PART-NAME . "WORLD") (:KIND-NAME . "WORLD")) ((:PART-NAME . "HELLO") (:KIND-NAME . "HELLO")) ((:PART-NAME . "STRING-JOIN") (:KIND-NAME . "STRING-JOIN"))) (:WIRING ((:WIRE-INDEX . 0) (:SOURCES ((:PART . "HELLO") (:PIN . "S"))) (:RECEIVERS ((:PART . "STRING-JOIN") (:PIN . "A")))) ((:WIRE-INDEX . 1) (:SOURCES ((:PART . "WORLD") (:PIN . "S"))) (:RECEIVERS ((:PART . "STRING-JOIN") (:PIN . "B")))) ((:WIRE-INDEX . 2) (:SOURCES ((:PART . "STRING-JOIN") (:PIN . "C"))) (:RECEIVERS ((:PART . "SELF") (:PIN . "RESULT")))) ((:WIRE-INDEX . 3) (:SOURCES ((:PART . "SELF") (:PIN . "START"))) (:RECEIVERS ((:PART . "WORLD") (:PIN . "START")) ((:PART . "HELLO") (:PIN . "START"))))))))