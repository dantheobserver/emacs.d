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


(defun utils/code-header (header)
  (interactive "sEnter Header: ")
  (let ((formatted-header (with-temp-buffer
			    (let* ((count (length header))
				   (margin 2)
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
			      ))))
    (save-excursion
      (beginning-of-line)
      (insert formatted-header))))


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
