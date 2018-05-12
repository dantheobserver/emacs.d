;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun setup|add-packages (lisp-dir)
  (dolist (package-dir (directory-files lisp-dir t "\\w+"))
    (when (file-directory-p package-dir)
      (add-to-list 'load-path package-dir)
      (add-to-list 'load-path (concat package-dir "/lisp")))))

(defun setup|load-path ()
  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  (setup/add-packages (expand-file-name "site-lisp" user-emacs-directory)))

(setup|load-path)

(require 'bootstrap-use-package)
(require 'init-common)
(require 'init-utils)

(utils|use-package-enable which-key
  (setq-default which-key-idle-delay 0.2))

;; TODO Prevent esc from exiting ivy
(utils|use-package-enable ivy
  (setq-default ivy-use-virtual-buffers 1)
  (add-to-list 'ivy-re-builders-alist '(t . ivy--regex-fuzzy))
  (general-define-key
   :states 'normal
   "ESC" 'keyboard-escape-quit))


;; Evil
(utils|use-package-enable evil)
(utils|use-package-enable evil-escape
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "fd"))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; TODO: Get working with movement keys
(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (setq golden-ratio-exclude-modes '(ranger-mode))
  (setq golden-ratio-extra-commands '(evil-window-left
                                      evil-window-right
                                      evil-window-up
                                      evil-window-down
                                      'winum-select-window-1
                                      'winum-select-window-2
                                      'winum-select-window-3
                                      'winum-select-window-4
                                      'winum-select-window-5
                                      'winum-select-window-6)))

(use-package winum
  :ensure t
  :config
  (winum-mode)) 
(use-package counsel-projectile :ensure t)
(use-package ranger :defer t)

(require 'init-lisps)
;;;;;;;;;;;;;;;;;
;; Source Control
;;;;;;;;;;;;;;;;;
(use-package magit :ensure t)
(use-package evil-magit
  :ensure t
  :requires magit)

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))

(require 'keymap-init)
