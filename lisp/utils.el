;; Helper Macros, externalize
(defmacro comment (&rest body) nil)

(defun utils//--get-path (path-list)
  (format "~/.emacs.d/%s" (string-join path "/")))

(defun utils//open-config-file (&rest path)
  (interactive)
  (find-file (utils//--get-path path)))

(defun utils//open-emacs-directory ()
  (interactive)
  (counsel-file-jump "" "~/.emacs.d/"))

(defun utils//split-window-right-and-focus ()
  (interactive)
  (split-window-right)
  (windmove-right))

(defun utils//split-window-below-and-focus ()
  (interactive)
  (split-window-below)
  (windmove-down))

(defmacro utils//wkbinding (name &rest body)
  (declare (indent 1))
  `(list
    (lambda ()
      (interactive)
      ,@body)
    :which-key ,name))

(defun utils//nav-comment-sections ()
  (interactive)
  (swiper-avy ";;\\*"))

(defun utils//comment-and-yank ()
  (interactive)
  (if (region-active-p)
      (progn
	(kill-ring-save (region-beginning) (region-end))
	(comment-region (region-beginning) (region-end))
	(yank)
	(deactivate-mark)
	(previous-line))
    (progn
      (kill-ring-save (line-beginning-position) (line-end-position))
      (comment-line 1)
      (yank)
      (newline)
      (previous-line)
      (end-of-line))))

(defun utils//comment-line ()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(let* ((beg (region-beginning))
	       (end (region-end))
	       (lines (split-string (buffer-substring-no-properties beg-end) "\n"))
	       (lines-commented? (reduce (lambda (memo line)
					   (and memo (comment-only-p line)))
					 lines
					 :initial-value true)))
	  (if lines-commented?
	      (uncomment-region beg end)
	    (comment-region beg end)))
      (comment-line 1))))

;; (defun utils//comment-form ()
;;   )

(defun utils//symbol-concat (&rest values)
  (let ((stringified-values
	 (mapcar (lambda (val)
		   (if (symbolp val)
		       (symbol-name val)
		     val))
		 values)))
    (intern (apply #'concat stringified-values))))

(defun utils//maximize-restore-window ()
  (interactive)
  (let ((window-count (length (window-list))))
    (if (= window-count 1)
	(winner-undo)
      (delete-other-windows))))

(defun utils//insert-line-numbers (start end text insert-extra-line)
  (interactive
   (let ((begin (if (region-active-p) (region-beginning) (point-min)))
	 (end (if (region-active-p) (region-end) (point-max)))
	 (insert-extra-line
	  (y-or-n-p "insert extra line")))
     (list begin
	   end
	   (buffer-substring-no-properties begin end)
	   insert-extra-line)))
  (let* ((line 0) 
	 (lines (split-string text "\n"))
	 (numbered-lines (mapcar (lambda (current-line)
				   (setq line (+ 1 line))
				   (if (zerop (length (string-trim current-line)))
				       current-line
				     (concatenate 'string
						  (number-to-string line)
						  ". "
						  current-line)))
				 lines)))
    (save-excursion 
      (delete-region start end)
      (insert (string-join lines (if insert-extra-line "\n\n" "\n"))))))

(defun utils/code-header (header)
  (interactive "sEnter Header: ")
  (let (save-excursion
	 (beginning-of-line)
	 (insert formatted-header))
    ((formatted-header (with-temp-buffer
			 (let* ((count (length header))
				(margin 2)
				(line-length 80)
				(line-length (+ count (* 2 margin) 2)))
			   ;; Top line
			   (insert ";;")
			   (insert-char ?\= line-length)
			   (insert "\n")
			   ;; Title
			   (insert ";;=")
			   (insert-char ?\s margin)
			   (insert header)
			   (insert-char ?\s margin)
			   (insert "=\n")
			   (insert ";;")
			   (insert-char ?\= line-length)
			   (insert "\n")
			   ;; (message (buffer-string))
			   (buffer-string)
			   ))))))


(provide 'utils)
;;===========
;;= testing =
;;===========

(comment
 (utils//layout-config)
 (equal '(1 2 3) '(1 2 4))
 (nth 2 '(1 2 3))
 (alist-get 1 (utils//layout-config))
 (seq-position '((1 . 1) (3 . 3) (2 . 2))
	       2
	       (lambda (a b) (= (car a) b)))

 (let ((cfg (utils//layout-config)))
   (equal (car cfg)
	  (cons 1 (cdar cfg))))

 (let ((cfg (utils//layout-config)))
   (cdar cfg))

 (defvar my-layout (utils//layout-config))


 )
