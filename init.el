;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (if (< (string-to-number emacs-version) 27)
;;     (package-initialize))

(defun setup//add-packages (lisp-dir)
  (dolist (package-dir (directory-files lisp-dir t "\\w+"))
    (when (file-directory-p package-dir)
      (add-to-list 'load-path package-dir)
      (add-to-list 'load-path (concat package-dir "/lisp")))))

(defun setup//load-path ()
  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  (setup//add-packages (expand-file-name "site-lisp" user-emacs-directory)))

(setup//load-path)

(require 'bootstrap-use-package)
(require 'init-evil-mode)
(require 'init-common)
(require 'init-hydras)
(require 'init-lisps)
(require 'init-rust)
(require 'init-keymaps)
(require 'init-themes)
(require 'init-js)

;; Utilities
(use-package dash :ensure t)
(use-package s :ensure t)
(use-package expand-region :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.2)
  (setq max-mini-window-height 20)
  (setq which-key-popup-type 'side-window))

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

;; https://github.com/cyrus-and/zoom
(use-package zoom
  :ensure t
  :config
  (zoom-mode t)
  (setq zoom-size '(0.618 . 0.618)
	zoom-ignored-major-modes '(which-key-mode hydra-mode)
	zoom-ignored-buffer-name-regexps '("\\*Help\\*" "\\*which-key\\*")
	zoom-minibuffer-preserve-layout t))

(use-package indent-guide
  :ensure t
  :config
  (indent-guide-global-mode))

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
  :hook (after-init . global-company-mode)
  :config
  (company-mode 1)
  (setq company-idle-delay nil))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook ((clojure-mode clojurescript-mode emacs-lisp-mode racket-mode) . rainbow-delimiters-mode))

;; TODO - https://github.com/istib/rainbow-blocks

;; ==Source Control==
(use-package magit :ensure t)

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("🐙" "💩" "🎃" "🍁" "◉" "○" "✸" "✿"))
  (setq org-agenda-files '("~/gtd/inbox.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org"))

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
				 (file+headline "~/gtd/inbox.org" "Tasks")
				 "* TODO %i%?")
				("T" "Tickler" entry
				 (file+headline "~/gtd/tickler.org" "Tickler")
				 "* %i%? \n %U"))))
(use-package org-pomodoro
  :after org
  :ensure t)

(use-package discover
  :ensure t
  :init
  (global-discover-mode 1))

(use-package emojify
  :ensure t
  :hook (org-mode . emojify-mode))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets :ensure t)
  (yas-global-mode t))

(use-package moody
  :ensure t
  :config
  (setq mode-line-format
	'("%e"
	  (:eval
	   (format winum-format
		   (winum-get-number-string)))
	  mode-line-front-space
	  mode-line-mule-info
	  mode-line-client
	  mode-line-modified
	  mode-line-remote
	  mode-line-frame-identification
	  moody-mode-line-buffer-identification
	  sml/pos-id-separator
	  mode-line-position
	  evil-mode-line-tag
	  (vc-mode moody-vc-mode)
	  sml/pre-modes-separator
	  mode-line-modes
	  mode-line-misc-info
	  mode-line-end-spaces))
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  ;; (moody-replace-vc-mode)
  (use-package minions :ensure t
    :config
    (minions-mode)))

(use-package emmet-mode :ensure t
  :hook (css-mode html-mode mhtml-mode))

(use-package all-the-icons
  :ensure t
  :pin "melpa"
  :config
  (use-package neotree
    :ensure t
    :config
    (setq neo-theme (if (display-graphic-p) 'icons 'nerd))))

(use-package lsp-mode
  :ensure t
  :commands lsp)
;; (use-package lsp-ui :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode) .
	 (lambda () (require 'ccls) (lsp))))

(add-to-list 'magic-mode-alist '("\\.c\\'" . c-mode))


;; (use-package lsp-ui :ensure t :after lsp-mode)
;; (use-package company-lsp :ensure t :after lsp-mode)
