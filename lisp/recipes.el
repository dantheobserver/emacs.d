;; tempbuffer
;;  Good for text manipulation on  
(with-temp-buffer
  (insert "a")
  (insert "b")
  (buffer-string))

;; region active
(region-active-p)

;; string at region
(buffer-substring-no-properties (region-beginning) (region-end))

;; beginning and end of buffer
(buffer-substring-no-properties (point-min) (point-max))

;; Get name of symbol
;; "test"
(symbol-name 'test)

;; ("testing" "one" "two" "testing")
(-map #'symbol-name '(testing one two testing))

(defmacro symbol-fun
    (&rest syms)
  `(s-concat ,@(mapcar 'symbol-name syms)))

(macroexpand-all `(symbol-fun test one two))

;; see if function symbol is bound 
(fboundp 'testing) ;;nil
(fboundp 'funcall) ;;t

;; Loops
(loop for i
      in '((:a 1) (:a 1))
      collect (plist-get i :a))

(loop for i
      in '("a" "b" "c" "d")
      do (insert i))
