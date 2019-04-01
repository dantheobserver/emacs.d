;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
(require 'init-common)
(require 'init-hydras)
(require 'init-lisps)
(require 'init-keymaps)

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.2)
  (setq max-mini-window-height 20)
  (setq which-key-popup-type 'side-window))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'respectful)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)
  (sml/setup))

;;``````````;;
;; /(    )\ ;;  
;; ==Evil== ;;
;;..........;;
(use-package evil
  :ensure t
  :init 
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer nil)
  (evil-mode 1)
  (global-set-key (kbd "C-u") 'evil-scroll-up)
  
  ;;configure key-chords
  (use-package key-chord
    :config
    (setq key-chord-two-keys-delay 0.3)
    (key-chord-define evil-insert-state-map "fj" 'evil-write)
    (key-chord-define evil-normal-state-map "fj" 'evil-write)
    (key-chord-mode 1))

  (use-package evil-escape
    :config
    (evil-escape-mode 1)
    (setq-default evil-escape-delay 0.4)
    (setq-default evil-escape-key-sequence "fd"))
  
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))

  (use-package evil-collection
    :ensure t
    :init
    (setq evil-collection-mode-list nil)
    (setq evil-collections-setup-minibuffer t)
    :config
    (evil-collection-init '(minibuffer ivy dired magit)))

  (use-package evil-leader
    :after org
    :ensure t) 

  (use-package evil-org
    :ensure t
    :config
    (evil-define-key 'normal evil-org-mode-map (kbd "H") 'org-shiftleft)
    (evil-define-key 'normal evil-org-mode-map (kbd "J") 'org-shiftdown)
    (evil-define-key 'normal evil-org-mode-map (kbd "K") 'org-shiftup)
    (evil-define-key 'normal evil-org-mode-map (kbd "L") 'org-shiftright))

  ;; (use-package evil-common
  ;;   :load-path "site-lisp/evil-common"
  ;;   :config
  ;;   (define-and-bind-text-object )
  ;;   )
  )

;; ==Navigation==
(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (setq counsel-grep-base-command
	"rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (add-to-list 'ivy-initial-inputs-alist '(counsel-M-x . ""))
  (add-to-list 'ivy-initial-inputs-alist '(counsel-desribe-function . ""))
  (add-to-list 'ivy-initial-inputs-alist '(counsel-describe-variable . ""))

  (use-package projectile
    :config
    (projectile-mode +1)
    (setq projectile-indexing-method 'hybrid)
    (setq projectile-sort-order 'recentf)

    (use-package counsel-projectile
      :ensure t)))

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
	zoom-ignored-buffer-name-regexps '(" *Help" " *which-key*")
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
  (add-to-list 'popwin:special-display-config '("*Messages*"))
  (add-to-list 'popwin:special-display-config '("*Backtrace*" :noselect t))
  (add-to-list 'popwin:special-display-config 'calculator-mode)
  )

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
(use-package magit
  :ensure t
  :config
  (use-package evil-magit :ensure t))

(use-package spacemacs-theme
  :pin "melpa-unstable"
  :defer t ;; Does not require
  :ensure t
  :init (load-theme 'spacemacs-dark t)
  :config
  (spacemacs-theme-org-highlight t))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config

  (setq org-bullets-bullet-list '("🐙" "💩" "🎃" "🍁" "◉" "○" "✸" "✿")))

(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))
(use-package emojify
  :ensure t
  :config
  (global-emojify-mode t))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets :ensure t)
  (yas-global-mode t))

