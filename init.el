;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq site-lisp-dir
      (expand-file-name "lisp" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path site-lisp-dir)
(require 'bootstrap-use-package)
(require 'init-common)
(require 'init-utils)

(utils--use-enable-package which-key
  (setq-default which-key-idle-delay 0.2))

;; TODO Prevent esc from exiting ivy
(utils--use-enable-package ivy
  (setq-default ivy-use-virtual-buffers 1)
  ;;(setq-default enable-recursive-minibuffers 1)
  (add-to-list 'ivy-re-builders-alist '(t . ivy--regex-fuzzy))
  (general-define-key
   :states 'normal
   "ESC" 'keyboard-escape-quit))
  

;; Evil
(utils--use-enable-package evil)

(utils--use-enable-package evil-escape
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
(use-package ranger :ensure t)

;; Clojure/lisp packages
(use-package clojure-mode :ensure t)
(use-package cider
  :requires clojure-mode)
(use-package lispy
  :ensure t
  :hook ((emacs-lisp-mode
	  clojure-mode
	  clojurescript-mode
	  clojurec-mode) . lispy-mode))

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

(use-package general :ensure t
  :config
  (set-frame-font "IBMPlexMono 14" nil t)
  (general-define-key
   :states 'visual
   "s" 'evil-surround-region)

  (general-define-key
   :states 'motion
   ";" 'evil-ex
   ":" 'evil-repeat-find-char
   "C-u" 'evil-scroll-up)

  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; simple command
   "u"   'universal-argument
   "'"   '(iterm-focus :which-key "iterm")
   "?"   '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
   "/"   'counsel-ag
   "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "SPC" '(counsel-M-x :which-key "M-x")
   "1" 'winum-select-window-1
   "2" 'winum-select-window-2
   "3" 'winum-select-window-3
   "4" 'winum-select-window-4
   "5" 'winum-select-window-5
   "6" 'winum-select-window-6

   ;; window
   "w" '(:ignore t :which-key "window")
   "wd" 'delete-window
   "wv" 'split-window-below
   "wV" 'split-window-below-and-focus
   "ws" 'split-window-right
   "wS" 'split-window-right-and-focus
   "wk" 'evil-window-up
   "wj" 'evil-window-down
   "wh" 'evil-window-left
   "wl" 'evil-window-right

   ;; variables

   ;; files
   "f" '(:ignore t :which-key "find")
   "fs" 'save-buffer
   "ff" 'counsel-find-file
   "fl" 'counsel-find-library

   ;; projects
   "p" '(:ignore t :which-key "projects")
   "ph" 'counsel-projectile  
   "pp" 'counsel-projectile-switch-project
   "p/" 'counsel-projectile-ag  
   "pb" 'counsel-projectile-switch-to-buffer
   "pf" 'counsel-projectile-find-file
   "pd" 'counsel-projectile-find-dir

   ;; buffers
   "b" '(:ignore t :which-key "buffers")
   "bp" 'previous-buffer
   "bn" 'next-buffer

   ;; help
   "h" '(:ignore t :which-key "help")
   "hd" '(:ignore t :which-key  "describe")
   "hdm" '(describe-mode :which-key "describe mode")
   "hdf" '(counsel-describe-function :which-key "describe function")
   "hdv" '(counsel-describe-variable :which-key "describe variable")
   "hdk" '(describe-key :which-key "describe key")
   "hm" '(view-echo-area-messages :which-key "messages buffer")
   "hc" '(:ignore t :which-key "customize")
   "cv" 'customize-variable
   "cg" 'customize-group

   ;; Applications
   "a" '(:ignore t :which-key "Applications")
   "ar" 'ranger
   "ad" 'dired

   ;; Git
   "g" '(:ignore t :which-key "Magit")
   "gs" 'magit-status

   ;; ivy
   "s"  '(:ignore t :which-key "ivy")
   "ss" 'swiper
   "sr" 'ivy-resume

   ;; quit and close
   "q" '(:ignore t :which-key "quit")
   "qq" '(save-buffers-kill-terminal :which-key "save & quit")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (winum golden-ratio solarized-theme counsel-projectile cider spinner whick-key which-key use-package ranger general evil counsel)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
