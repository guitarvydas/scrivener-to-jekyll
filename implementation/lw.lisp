(uiop:run-program "~/quicklisp/local-projects/arrowgrams/rm.bash")
(ql:register-local-projects)
(ql:quickload :sl :silent nil) ;; needed by SL:parse in eval-whens
(ql:quickload :arrowgrams/build :silent nil)

