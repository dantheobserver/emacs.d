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

;;;;;;;;;;;;;;;;;;;;;;
;; Which key macros ;;
;;;;;;;;;;;;;;;;;;;;;;
(defun -flatmap (fn coll)
  (reduce (lambda (a b) (append a (funcall fn b)))
          coll
          :initial-value nil))

(defun -wk--entry (entry-char fn-call &optional description)
  `(,entry-char (,fn-call :which-key ,description)))

(defmacro wk--single-entries (&rest entries)
  (-flatmap (lambda (item) (apply '-wk--entry item))
            entries))

(defmacro wk--leader-key-bindings (body)
  `(general-define-key
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC"
    ,@body))

(provide 'init-utils)

