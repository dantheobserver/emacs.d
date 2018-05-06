;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

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
  (setq-default enable-recursive-minibuffers 1))
(utils--use-enable-package evil)
(utils--use-enable-package evil-escape
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "fd"))
(use-package counsel :ensure t)
(use-package ranger :ensure t)

(use-package general :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; simple command
   "'"   '(iterm-focus :which-key "iterm")
   "?"   '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
   "/"   'counsel-ag
   "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "SPC" '(counsel-M-x :which-key "M-x")

   ;; help
   "h" (utils--which-key-header "help")
   "hd" (utils--which-key-header "describe")
   "hdm" '(describe-mode :which-key "describe-mode")

   ;; Applications
   "a" '(:ignore t :which-key "Applications")
   "ar" 'ranger
   "ad" 'dired

   "s" (utils--which-key-header "ivy")
   "ss" (utils--which-key-binding "swiper" swiper)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (whick-key which-key use-package ranger general evil counsel))))
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
