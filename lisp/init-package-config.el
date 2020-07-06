;; -*- lexical-binding: t -*-

(use-package dash :ensure t)

(use-package expand-region :ensure t)

(use-package all-the-icons :ensure t)

(use-package treemacs :ensure t
  :after all-the-icons
  :config
  (add-hook 'treemacs-mode-hook #'evil-normalize-keymaps)
  (setq treemacs-width 25))

(use-package docker :ensure t)

(use-package general
  :ensure t
  :init
  :functions (mmap nmap iemap imap itomap otomap)
  :config
  (add-to-list 'general-keymap-aliases '(elisp . emacs-lisp-mode-map))
  (add-to-list 'general-keymap-aliases '(miracle . miracle-mode-map))
  (add-to-list 'general-keymap-aliases '(miracle-interaction. miracle-interaction-mode-map))
  (add-to-list 'general-keymap-aliases '(clj . clojure-mode-map))
  (add-to-list 'general-keymap-aliases '(cljs . clojurescript-mode-map))
  (add-to-list 'general-keymap-aliases '(cider . cider-mode-map))
  (add-to-list 'general-keymap-aliases '(ielm . ielm-map))
  (add-to-list 'general-keymap-aliases '(cider-repl . cider-repl-mode-map))
  (add-to-list 'general-keymap-aliases '(cider-doc . cider-doc-mode-map))
  (add-to-list 'general-keymap-aliases '(racket . racket-mode-map))
  (add-to-list 'general-keymap-aliases '(racket-repl . racket-repl-mode-map))
  (add-to-list 'general-keymap-aliases '(clj-stacktrace . cider-stacktrace-mode-map))
  (add-to-list 'general-keymap-aliases '(help . help-mode-map))
  (add-to-list 'general-keymap-aliases '(global . global-map))
  (add-to-list 'general-keymap-aliases '(evil-org . evil-org-mode-map))
  (general-evil-setup t))

;; https://github.com/justbur/emacs-which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.2)
  (setq which-key-popup-type 'side-window)
  (setq which-key-side-window-max-height 10))

(use-package restart-emacs :ensure t)

(use-package smex :ensure t)

(use-package counsel
  :ensure t
  :after smex
  :config
  (ivy-mode 1)
  (setq ivy-count-format "(%d/%d) ")
  (setq counsel-grep-base-command
	"rg -i -M 120 --no-heading --line-number --color never %s %s")
  (setq ivy-use-selectable-prompt t)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (add-to-list 'ivy-initial-inputs-alist '(counsel-M-x . ""))
  (add-to-list 'ivy-initial-inputs-alist '(counsel-desribe-function . ""))
  (add-to-list 'ivy-initial-inputs-alist '(counsel-describe-variable . "")))

(use-package projectile
  :ensure t
  :commands (counsel-projectile-find-file
	     projectile-find-file-dwim
	     counsel-projectile-switch-project
	     projectile-invalidate-cache)
  :config
  (projectile-mode +1)
  (setq projectile-sort-order 'recentf)
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'hybrid)
  (use-package counsel-projectile :ensure t))

(use-package dumb-jump
  :ensure t
  :commands (dumb-jump-go-current-window
	     dumb-jump-quick-look)
  :general
  (:keymaps 'prog-mode-map
   :states 'normal
   "gd" 'dumb-jump-go-current-window)

  :config
  (setq dumb-jump-selector 'ivy)
  (setq dumb-jump-force-searcher 'ag)
  ;; (setq dumb-jump-rg-cmd "rg -P")
  )

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode t)
  (eyebrowse-setup-evil-keys)
  (setq eyebrowse-mode-line-separator " "
	eyebrowse-new-workspace t
	eyebrowse-wrap-around t
	eyebrowse-mode-line-style t))

(use-package eb-layout
  :load-path "site-lisp/eb-layout.el"
  :config
  (add-to-list 'desktop-globals-to-save 'ebl-saved-layouts)
  (add-to-list 'desktop-globals-to-save 'ebl-layout-name)
  ;;(ebl-load-layout "main")
  )

;; https://github.com/cyrus-and/zoom
(defun utils//fix-which-key ()
  (with-selected-window (get-buffer-window "*which-key*")
    (setq window-size-fixed t)
    (window-resize (selected-window) (- (window-total-height) 4) t t)))

(use-package zoom
  :ensure t
  :config
  (zoom-mode t)
  (add-hook 'which-key-mode-hook #'utils//fix-which-key)
  (setq zoom-size '(0.618 . 0.618)
	zoom-ignored-major-modes '(which-key-mode hydra-mode)
	zoom-ignored-buffer-name-regexps '("\\*Help\\*" "\\*which-key\\*")
	zoom-minibuffer-preserve-layout t))

;; https://github.com/zk-phi/indent-guide
(use-package indent-guide
  :ensure t
  :config
  (indent-guide-global-mode))

;;https://github.com/antonj/Highlight-Indentation-for-Emacs/
;; (use-package highlight-indentation
;;   :ensure t
;;   :hook '(prog-mode . highlight-indentation-mode)
;;   :config
;;   (highlight-indentation-mode)
;;   (set-face-background 'highlight-indentation-face "#3f5958")
;;   ;; (highlight-indentation-current-column-mode)
;;   )

;;https://github.com/m2ym/popwin-el
(use-package popwin
  :ensure t
  :config
  (popwin-mode 1)
  (add-to-list 'popwin:special-display-config '("*Warnings*" :noselect t))
  (add-to-list 'popwin:special-display-config '("*Backtrace*" :noselect t))
  (add-to-list 'popwin:special-display-config '("*Backtrace*" :noselect t))
  (add-to-list 'popwin:special-display-config 'calculator-mode))

;;TODO Prevent esc from exiting ivy
(use-package winner
  :ensure t
  :config
  (winner-mode))

(use-package winum
  :ensure t
  :config
  (winum-mode)) 

(use-package company
  :ensure t
  :commands company-complete
  :hook '(after-init . global-company-mode)
  :config
  (company-mode 1)
  (setq company-idle-delay nil))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode racket-mode) . rainbow-delimiters-mode))

;; TODO - https://github.com/istib/rainbow-blocks

(with-eval-after-load 'edebug
  (evil-make-overriding-map edebug-mode-map '(normal motion))
  (add-hook 'edebug-mode-hook 'evil-normalize-keymaps))

;; ==Source Control==
(use-package magit :ensure t
  :config
  ;; (setq magit-display-buffer-function 'magit-display-buffer-traditional)
  (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
  )

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets :ensure t)
  (yas-global-mode t))

;; Mode Line customization
(use-package minions
  :ensure t)
(use-package telephone-line
  :ensure t
  :config
  ;; https://github.com/dbordak/telephone-line/blob/master/examples.org
  (setq telephone-line-lhs
	'((evil   . (telephone-line-evil-tag-segment))
          (accent . (telephone-line-vc-segment
                     telephone-line-erc-modified-channels-segment
                     telephone-line-process-segment))
          (nil    . (telephone-line-buffer-segment))))
  (setq telephone-line-rhs
	'((nil    . (telephone-line-misc-info-segment))
          (accent . (telephone-line-minions-mode-segment))
          (evil   . (telephone-line-airline-position-segment))))
  (telephone-line-mode 1))

(use-package emmet-mode :ensure t
  :hook (css-mode html-mode mhtml-mode))

;; (use-package neotree
;;   :ensure t
;;   :config
;;   (setq neo-theme (if (display-graphic-p) 'icons 'nerd)))

;; LSP c programming
(use-package lsp-mode
  :ensure t
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-include-signature t))

(use-package company-lsp
  :ensure t
  :after company
  :commands company-lsp
  :config
  (add-to-list 'company-backends 'company-lsp))

(defun ccls-start ()
  (interactive)
  (require 'ccls)
  (lsp))

(use-package ccls
  :ensure t
  ;; :hook ((c-mode c++-mode) . #'ccls-start)
  )

(add-to-list 'magic-mode-alist '("\\.c\\'" . c-mode))

;; (use-package lsp-ui :ensure t :after lsp-mode)
;; (use-package company-lsp :ensure t :after lsp-mode)
(provide 'init-package-config)
