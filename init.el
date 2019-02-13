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
  (setq-default which-key-idle-delay 0.2))

;;;;;;;;;;
;; Evil ;;
;;;;;;;;;;
(use-package evil
  :ensure t
  :init 
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer t)
  :config
  (evil-mode 1)
  (setq evil-want-minibuffer t)
  (global-set-key (kbd "C-u") 'evil-scroll-up))

(use-package evil-escape
  :ensure t
  :after evil
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
  :after evil
  :init
  (setq evil-collection-mode-list nil)
  (setq evil-collections-setup-minibuffer t)
  :config
  (require 'evil-collection-minibuffer)
  (require 'evil-collection-magit)
  (require 'evil-collection-ivy))

;;;;;;;;;;;;;;;;
;; Navigation ;;
;;;;;;;;;;;;;;;;

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
  (add-to-list 'ivy-initial-inputs-alist '(counsel-describe-variable . "")))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package counsel-projectile
  :ensure t
  :after (counsel projectile))

;; TODO: Get working with movement keys
(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale nil)
  (setq golden-ratio-exclude-modes '(minibuffer-inactive-mode))
  (setq golden-ratio-extra-commands '(evil-window-left
                                      evil-window-right
                                      evil-window-up
                                      evil-window-down
				      split-window-below
				      split-window-right
				      windmove-down
				      windmove-right
				      magit-status
				      help-mode
				      counsel-describe-functon
				      counsel-describe-map
				      counsel-describe-variable
                                      winum-select-window-1
                                      winum-select-window-2
                                      winum-select-window-3
                                      winum-select-window-4
                                      winum-select-window-5
                                      winum-select-window-6
				      keyboard-quit
				      quit-window)))

;; TODO Prevent esc from exiting ivy
(use-package winum
  :ensure t
  :config
  (winum-mode)) 

(use-package company
  :ensure t
  :commands company-complete
  :config
  (company-mode 1)
  (setq company-idle-delay nil)
  (add-hook 'after-init-hook 'global-company-mode))

(use-package smart-mode-line
  :ensure t
  :config
  (sml/setup)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t))

(use-package linum-relative
  :ensure t
  :load-path "site-lisp/linum-relative"
  :init
  (setq linum-relative-current-symbol "")
  (setq linum-relative-backend 'display-line-numbers)
  :config
  (linum-relative-global-mode 1))

;;;;;;;;;;;;;;;;;
;; Source Control
;;;;;;;;;;;;;;;;;
(use-package magit :ensure t)

(use-package evil-magit
  :ensure t
  :requires magit)

(use-package spacemacs-theme
  :pin "melpa-unstable"
  :defer t ;; Does not require
  :ensure t
  :init (load-theme 'spacemacs-dark t)
  :config
  (spacemacs-theme-org-highlight t))

;;TODO Better organization required
;;Maybe have the keymaps be function blocks
;;to be called in init.el
;;(require 'init-keymaps)
