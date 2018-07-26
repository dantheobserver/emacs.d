;; Clojure/lisp packages
(use-package clojure-mode :ensure t)

(use-package cider :ensure t
  :hook (clojure-mode . cider-mode)
  :pin "melpa")

(use-package clj-refactor
  :ensure t
  :pin "melpa-unstable")

(use-package evil-lispy
  :ensure t
  :hook clojure-mode)

(provide 'init-lisps)
