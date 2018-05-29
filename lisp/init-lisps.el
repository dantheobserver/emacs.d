;; Clojure/lisp packages
(use-package clojure-mode :ensure t)

(use-package cider :ensure t
  :hook (clojure-mode . cider-mode)
  :pin "melpa")

(use-package clj-refactor
  :ensure t
  :pin "melpa-unstable")

(use-package evil-cleverparens
  :ensure t
  :hook ((clojure-mode . evil-cleverparens-mode)
         (clojurescript-mode . evil-cleverparens-mode)
         (clojurec-mode . evil-cleverparens-mode)))

;; (use-package lispy
;;   :ensure t
;;   :hook
;;   ((emacs-lisp-mode
;;     clojure-mode
;;     clojurescript-mode
;;     clojurec-mode)
;;    . lispy-mode)
;;   :config
;;   (setq lispy-close-quotes-at-end-p t))

;; (use-package lispyville
;;   :ensure t
;;   :requires lispy
;;   :hook
;;   ((lispy-mode . lispyville-mode))
;;   :config)

(provide 'init-lisps)
