;;tempbuffer
;; Good for text manipulation on  
(with-temp-buffer
  (insert "a")
  (insert "b")
  (buffer-string))

