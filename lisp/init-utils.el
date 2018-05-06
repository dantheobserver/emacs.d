;; Helper Macros, externalize
(defmacro utils--use-enable-package (name &rest body)
  (declare (indent defun))
  (let ((mode-name (intern
                    (concat (symbol-name name) "-mode"))))
    `(use-package ,name :ensure t
       :config (,mode-name 1)
       ,@body)))

(defmacro utils--which-key-header (name)
  `'(:ignore t :which-key ,name))

(defmacro utils--which-key-binding (name cmd)
  `'(,cmd :which-key ,name))

(provide 'init-utils)
