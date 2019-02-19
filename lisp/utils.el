;; Helper Macros, externalize
(defun utils//open-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

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


