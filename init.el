(setq delete-old-versions -1)    ; delete excess backup versions silently
(setq version-control t)    ; use version control
(setq vc-make-backup-files t)    ; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups"))) ; which directory to put backups file
(setq vc-follow-symlinks t)               ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))) ;transform backups file name
(setq inhibit-startup-screen t)  ; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore)  ; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8)  ; use utf-8 by default
(setq coding-system-for-write 'utf-8)
(setq sentence-end-double-space nil)  ; sentence SHOULD end with only a point.
(setq default-fill-column 80)    ; toggle wrapping text at the 80th character

;; Helper Macros, externalize
(defmacro config--use-enable-package (name &rest body)
  (declare (indent defun))
  (let ((mode-name (intern
                    (concat (symbol-name name) "-mode"))))
    `(use-package ,name :ensure t
       :config (,mode-name 1)
       ,@body)))

(defmacro config--which-key-header (name)
  `'(:ignore t :which-key ,name))

(defmacro config--which-key-binding (name cmd)
  `'(,cmd :which-key ,name))


;;Initialize Package
(require 'package)
(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(package-initialize) ; guess what this one does ?

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package) ; guess what this one does too ?

(config--use-enable-package which-key
  (setq-default which-key-idle-delay 0.2))
(config--use-enable-package ivy
  (setq-default ivy-use-virtual-buffers 1)
  (setq-default enable-recursive-minibuffers 1))
(config--use-enable-package evil)
(config--use-enable-package evil-escape
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
   "h" (config--which-key-header "help")
   "hd" (config--which-key-header "describe")
   "hdm" '(describe-mode :which-key "describe-mode")

   ;; Applications
   "a" '(:ignore t :which-key "Applications")
   "ar" 'ranger
   "ad" 'dired

   "s" (config--which-key-header "ivy")
   "ss" (config--which-key-binding "swiper" swiper)))

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
 
