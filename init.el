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

(utils--use-enable-package ivy
  (setq-default ivy-use-virtual-buffers 1)
  (setq-default enable-recursive-minibuffers 1)
  (add-to-list 'ivy-re-builders-alist '(t . ivy--regex-ignore-order)))

(utils--use-enable-package evil)
(utils--use-enable-package evil-escape
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "fd"))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package counsel :ensure t)
(use-package counsel-projectile :ensure t)
(use-package ranger :ensure t)

(use-package clojure-mode :ensure t)

;; TODO: won't load 
(use-package lispy
  :ensure t
  :hook clojure-mode)

(use-package magit :ensure t)
(use-package evil-magit
  :ensure t
  :requires magit)

;; TODO: can't get cider to install
;; (use-package cider :ensure t)

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
   "V" '(:ignore t :which-key "variables")
   "Vc" 'customize-variable
   "Vg" 'customize-group

   ;; files
   "f" '(:ignore t :which-key "find")
   "fs" 'save-buffer
   "ff" 'counsel-find-file
   "fl" 'counsel-find-library

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
    (solarized-theme counsel-projectile cider spinner whick-key which-key use-package ranger general evil counsel))))
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
 
