;; Helper Macros, externalize
(defmacro utils//use-package-enable (name &rest body)
  (declare (indent 1))
  (let ((mode-name (intern
                    (concat (symbol-name name) "-mode"))))
    `(use-package ,name :ensure t
       :config (,mode-name 1)
       ,@body)))

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


(provide 'init-utils)

