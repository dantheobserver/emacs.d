;;tempbuffer
;; Good for text manipulation on  
(with-temp-buffer
  (insert "a")
  (insert "b")
  (buffer-string))

;;region active
(region-active-p)

;;string at region
(buffer-substring-no-properties (region-beginning) (region-end))

;;beginning and end of buffer
(buffer-substring-no-properties (point-min) (point-max))
