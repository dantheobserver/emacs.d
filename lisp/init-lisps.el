;; Clojure/lisp packages
(use-package clojure-mode :ensure t)

(use-package cider :ensure t
  :hook (clojure-mode . cider-mode)
  :pin "melpa")

(use-package clj-refactor
  :ensure t
  :pin "melpa-unstable")

(use-package aggressive-indent
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode) . aggressive-indent-mode))

(use-package evil-cleverparens
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode) . evil-cleverparens-mode)
  :init
  (setq evil-move-beyond t))

(provide 'init-lisps)
