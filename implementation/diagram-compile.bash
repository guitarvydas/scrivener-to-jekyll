#!/bin/bash
# usage: ./diagram-compile <filename.svg>
sbcl  --noinform \
      --eval '(uiop:run-program "~/quicklisp/local-projects/arrowgrams/rm.bash")' \
      --eval '(ql:register-local-projects)' \
      --eval '(ql:quickload :arrowgrams/build :silent nil)' \
      --eval "(arrowgrams/build::db-arrowgrams-to-json \"$1\")" \
      --quit
