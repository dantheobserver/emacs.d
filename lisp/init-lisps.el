;; Clojure/lisp packages
(require 'utils)

(use-package edebug
  :after 'evil 
  :config
  ;; (add-hook 'edebug-setup-hook 'normal-mode)
  ;; (add-hook 'edebug-setup-hook 'evil-execute-in-emacs-state)
  (add-hook 'edebug-setup-hook 'evil-normalize-keymaps))

(use-package clojure-mode :ensure t
  :config

  (use-package clj-refactor :ensure t
    :hook (clojure-mode . clj-refactor-mode))

  (use-package miracle
    :load-path "site-lisp/miracle"
    :config
    (add-hook 'clojure-mode-hook 'clojure-enable-miracle)))

(use-package racket-mode :ensure t)

(use-package cider :ensure 
  :hook ((clojure-mode clojurescript-mode) . cider-mode)
  :config
  (setq cider-pprint-fn 'puget)
  (setq cider-test-show-report-on-success nil)
  (setq cider-test-infer-test-ns 'cider-test-default-test-ns-fn)
  ;; (evil-set-initial-state 'cider--debug-mode 'emacs)
  (add-hook 'cider--debug-mode-hook #'evil-emacs-state)
  ;; (remove-hook 'cider-test-report-mode-hook (lambda ()
  ;; 					      (setq-local truncate-lines 1)))
  ;; (evil-set-initial-state 'cider-test-report-mode 'emacs)
  ;; (evil-set-initial-state 'cider-classpath-mode 'emacs)
  ;; (evil-set-initial-state 'cider-stacktrace-mode 'normal)
  )

(use-package aggressive-indent
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode racket-mode cider-repl) . aggressive-indent-mode)
  :config
  ;; Indentation of function forms
  ;; https://github.com/clojure-emacs/clojure-mode#indentation-of-function-forms
  ;; (setq clojure-indent-style 'align-arguments)
  (setq clojure-indent-style 'always-indent)
  ;;
  ;; Vertically align s-expressions
  ;; https://github.com/clojure-emacs/clojure-mode#vertical-alignment
  (setq clojure-align-forms-automatically nil)
  ;;
  )

(use-package evil-cleverparens
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode racket-mode cider-repl) . evil-cleverparens-mode)
  :init
  (setq evil-move-beyond t))

(use-package elec-pair
  :ensure t
  :hook ((clojure-mode cider-repl-mode clojurescript-mode emacs-lisp-mode racket-mode) . electric-pair-mode))

(use-package fuco
  :load-path "site-lisp/fuco"
  :config
  (setq lisp-indent-function 'fuco1/lisp-indent-function))

(provide 'init-lisps)
