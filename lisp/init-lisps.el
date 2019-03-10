;; Clojure/lisp packages
(require 'utils)

(use-package clojure-mode :ensure t)

(use-package racket-mode :ensure t
  :pin "melpa-unstable")

(use-package cider :ensure t
  :hook (clojure-mode . cider-mode)
  :pin "melpa")

(use-package clj-refactor
  :ensure t
  :pin "melpa-unstable")

(use-package aggressive-indent
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode racket-mode) . aggressive-indent-mode))

(use-package evil-cleverparens
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode racket-mode) . evil-cleverparens-mode)
  :init
  (setq evil-move-beyond t))

(use-package elec-pair
  :ensure t
  :hook ((clojure-mode cider-mode clojurescript-mode elisp-mode racket-mode) . electric-pair-mode))


(use-package fuco
  :load-path "site-lisp/fuco"
  :config
  (setq lisp-indent-function 'fuco1/lisp-indent-function))

(provide 'init-lisps)
