;; Helper Macros, externalize
(defmacro comment (&rest body)
  nil)

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
      (beginning-of-line))))

(defun utils//symbol-concat (&rest values)
  (let ((stringified-values (mapcar (lambda (val)
				      (if (symbolp val)
					  (symbol-name val)
					val))
				    values)))
    (intern (apply #'concat stringified-values))))

(defun utils//maximize-restore-window ()
  (interactive)
  (let ((window-count (length  (window-list))))
    (if (= window-count 1)
	(winner-undo)
      (ace-maximize-window))))

(defun utils//layout-config ()
  (eyebrowse--get 'window-configs))

(defun utils//set-layout-config (cfg)
  (eyebrowse--set 'window-configs cfg))

(defun shift-layout-to (direction boundary-fn &optional comparator-fn)
  (let* ((comparator-fn (or comparator-fn #'=))
	 (layout-config (utils//layout-config))
	 (current-slot (eyebrowse--get 'current-slot))
	 (cfg-idx (seq-position layout-config current-slot
				(lambda (cfg-item slot-num)
				  (= (car cfg-item) slot-num)))))
    ;; skip processing if boundary test fails
    (if (funcall boundary-fn cfg-idx layout-config)
	(let ((left-side (seq-subseq layout-config 0 cfg-idx))
	      (right-side (seq-subseq layout-config (1+ cfg-idx)))
	      (item (nth cfg-idx layout-config)))
	  (cond ((eq 'right direction)
		 (let ((other-slot (caar right-part))
		       (updated-item (cons other-slot (cdr item)))
		       (updated-other (cons current-slot (cdar right-part))))
		   (utils//set-layout-config 
		    (seq-concatenate 'list
				     left-part
				     (list updated-other updated-item)
				     (cdr right-part)))))
		((eq 'left direction)
		 (let ((other-slot (car (last left-part)))
		       (updated-item (cons other-slot (cdr item)))
		       (updated-other (cons current-slot (last left-side))))
		   (utils//set-layout-config
		    (seq concatenate
			 (seq-subseq left-side 0 (1- (length left-side)))
			 (liest updated-item updated-other)
			 right-side)))))))))

(defun utils//move-current-layout-right ()
  (interactive)
  (shift-layout-to 'right (lambda (cfg-idx config)
			    (< cfg-idx (1- (length config))))))

(defun utils//move-current-layout-left ()
  (interactive)
  (shift-layout-to 'left (lambda (cfg-idx _)
			   (> cfg-idx 0))))
(provide 'utils)

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


 )
