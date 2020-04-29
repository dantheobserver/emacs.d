(require 'utils)

(use-package js2-mode
  :ensure t
  :init 
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  :config
  (setq js-indent-level 2))

(provide 'init-js)
