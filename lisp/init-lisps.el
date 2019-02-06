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
  :after '(evil clojure-mode)
  :hook '((clojure-mode . evil-cleverparens-mode)
	  (clojurescript-mode . evil-cleverparens-mode)
	  (elisp-mode . evil-cleverparens-mode))
  :init
  (setq evil-move-beyond t)
  :config
  (add-hook 'clojure-mode-hook #'evil-cleverparens-mode)
  (add-hook 'clojurescript-mode-hook #'evil-cleverparens-mode)
  (add-hook 'elisp-mode-hook #'evil-cleverparens-mode))

(provide 'init-lisps)
