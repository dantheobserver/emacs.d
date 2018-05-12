;; Helper Macros, externalize
(defmacro utils|use-package-enable (name &rest body)
  (declare (indent 1))
  (let ((mode-name (intern
                    (concat (symbol-name name) "-mode"))))
    `(use-package ,name :ensure t
       :config (,mode-name 1)
       ,@body)))

(provide 'init-utils)

