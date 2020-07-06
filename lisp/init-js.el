(require 'utils)

(use-package js2-mode
  :ensure t
  :init 
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  :config
  (setq js-indent-level 2))

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*import React" . rjsx-mode))

  (setq-local company-tooltip-align-annotations t)

  (add-hook 'rjsx-mode-hook #'companhy-mode)
  )

(provide 'init-js)
