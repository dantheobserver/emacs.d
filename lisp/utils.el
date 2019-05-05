;; Helper Macros, externalize
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

(defmacro utils//diminish-after-load (&rest modes)
  (let ((statements (mapcar
		     (lambda (mode)
		       `(with-eval-after-load (symbol-name 'mode)
			  (diminish (utils//symbol-concat ',mode "-mode"))))
		     modes)))
    `(progn
       ,@statements)))

(provide 'utils)


