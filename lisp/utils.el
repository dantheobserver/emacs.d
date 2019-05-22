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
  (let ((stringified-values
	 (mapcar (lambda (val)
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


(defun swap-cfg-idx (current-idx next-idx cfg)
  (let ((item (nth current-idx cfg))
	(next-item (nth next-idx cfg)))
    (seq-map-indexed (lambda (cfg-item idx)
		       (cond ((= current-idx idx)
			      (cons next-idx (cdr next-item)))
			     ((= next-idx idx)
			      (cons current-idx (cdr item)))
			     (t cfg-item)))
		     cfg)))

(defun move-current-layout-to (direction)
  (interactive)
  (let* ((cfg (eyebrowse--get 'window-configs)) 
	 (cfg-count (length cfg))
	 (current-slot (eyebrowse--get 'current-slot))
	 (current-cfg-idx (seq-position cfg 1 (lambda (item elt)
						(= (car item) elt))))
	 (next-cfg-idx (cond ((eq direction 'left)
			      (1- current-cfg-idx))
			     ((eq direction 'right)
			      (1+ current-cfg-idx))
			     (t -1))))
    (if (< 0 next-cfg-idx cfg-count)
	(let* ((updated-cfg (swap-cfg-idx current-cfg-idx next-cfg-idx cfg)))
	  (eyebrowse--set 'window-configs updated-cfg)
	  (eyebrowse--set 'current-slot)))))

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

 (defvar my-layout (utils//layout-config))


 )
